import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import 'practice_repository.dart';
import 'quiz_controller.dart';

/// State of the Endless Survival Quiz mode with 3 lives.
class SurvivalState {
  final List<Vocabulary> pool;
  final QuizQuestion? currentQuestion;
  final int lives;
  final int score;
  final int bestScore;
  final bool isGameOver;
  final bool isAnswered;
  final String? selectedAnswer;
  final List<QuizMistake> mistakes;

  const SurvivalState({
    this.pool = const [],
    this.currentQuestion,
    this.lives = 3,
    this.score = 0,
    this.bestScore = 0,
    this.isGameOver = false,
    this.isAnswered = false,
    this.selectedAnswer,
    this.mistakes = const [],
  });

  SurvivalState copyWith({
    List<Vocabulary>? pool,
    QuizQuestion? currentQuestion,
    int? lives,
    int? score,
    int? bestScore,
    bool? isGameOver,
    bool? isAnswered,
    String? selectedAnswer,
    List<QuizMistake>? mistakes,
  }) {
    return SurvivalState(
      pool: pool ?? this.pool,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      lives: lives ?? this.lives,
      score: score ?? this.score,
      bestScore: bestScore ?? this.bestScore,
      isGameOver: isGameOver ?? this.isGameOver,
      isAnswered: isAnswered ?? this.isAnswered,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      mistakes: mistakes ?? this.mistakes,
    );
  }
}

class SurvivalNotifier extends AutoDisposeNotifier<SurvivalState> {
  @override
  SurvivalState build() => const SurvivalState();

  void startSurvival({required List<Vocabulary> pool}) {
    if (pool.isEmpty) return;

    final question = _generateRandomQuestion(pool);
    state = SurvivalState(
      pool: pool,
      currentQuestion: question,
      lives: 3,
      score: 0,
      bestScore: state.bestScore,
      isGameOver: false,
      isAnswered: false,
      mistakes: const [],
    );
  }

  Future<void> answer(String selectedOption) async {
    final question = state.currentQuestion;
    if (question == null || state.isAnswered || state.isGameOver) return;

    final isCorrect = selectedOption == question.correctAnswer;
    final updatedMistakes = List<QuizMistake>.from(state.mistakes);

    var newLives = state.lives;
    var newScore = state.score;

    if (isCorrect) {
      newScore++;
    } else {
      newLives--;
      updatedMistakes.add(
        QuizMistake(
          word: question.targetWord,
          userAnswer: selectedOption,
          correctAnswer: question.correctAnswer,
        ),
      );
    }

    final isOver = newLives <= 0;
    final newBest = newScore > state.bestScore ? newScore : state.bestScore;

    // Persist attempt into local database
    final repo = ref.read(practiceRepositoryProvider);
    await repo.recordQuizAttempt(
      vocabularyId: question.targetWord.id,
      direction: question.direction,
      questionType: 'survival',
      userAnswer: selectedOption,
      isCorrect: isCorrect,
    );

    state = state.copyWith(
      lives: newLives,
      score: newScore,
      bestScore: newBest,
      isGameOver: isOver,
      isAnswered: true,
      selectedAnswer: selectedOption,
      mistakes: updatedMistakes,
    );
  }

  void nextQuestion() {
    if (state.isGameOver || state.pool.isEmpty) return;

    final nextQ = _generateRandomQuestion(state.pool);
    state = state.copyWith(
      currentQuestion: nextQ,
      isAnswered: false,
      selectedAnswer: null,
    );
  }

  QuizQuestion _generateRandomQuestion(List<Vocabulary> pool) {
    final shuffled = List<Vocabulary>.from(pool)..shuffle();
    final target = shuffled.first;

    // Randomize direction: JP -> ID (70%) or ID -> JP (30%)
    final isJaToId = DateTime.now().millisecond % 3 != 0;
    final direction = isJaToId
        ? LearningDirection.jaToId
        : LearningDirection.idToJa;

    final wordDisplay = target.kanji != null
        ? '${target.kanji} (${target.hiragana})'
        : target.hiragana;

    final questionText = isJaToId
        ? 'Apa arti dari "$wordDisplay"?'
        : 'Bagaimana kosakata untuk "${target.meaning}"?';

    final correctAnswer = isJaToId ? target.meaning : target.hiragana;

    final distractors =
        pool
            .where((w) => w.id != target.id)
            .map((w) => isJaToId ? w.meaning : w.hiragana)
            .toSet()
            .toList()
          ..shuffle();

    final options = [correctAnswer, ...distractors.take(3)]..shuffle();

    return QuizQuestion(
      targetWord: target,
      direction: direction,
      questionText: questionText,
      correctAnswer: correctAnswer,
      options: options,
    );
  }
}

final survivalControllerProvider =
    NotifierProvider.autoDispose<SurvivalNotifier, SurvivalState>(
      SurvivalNotifier.new,
    );
