import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import 'practice_repository.dart';

class QuizQuestion {
  final Vocabulary targetWord;
  final LearningDirection direction;
  final String questionText;
  final String correctAnswer;
  final List<String> options;
  final String? selectedAnswer;
  final bool isAnswered;

  const QuizQuestion({
    required this.targetWord,
    required this.direction,
    required this.questionText,
    required this.correctAnswer,
    required this.options,
    this.selectedAnswer,
    this.isAnswered = false,
  });

  bool get isCorrect => selectedAnswer == correctAnswer;

  QuizQuestion copyWith({String? selectedAnswer, bool? isAnswered}) {
    return QuizQuestion(
      targetWord: targetWord,
      direction: direction,
      questionText: questionText,
      correctAnswer: correctAnswer,
      options: options,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isAnswered: isAnswered ?? this.isAnswered,
    );
  }
}

class QuizMistake {
  final Vocabulary word;
  final String userAnswer;
  final String correctAnswer;

  const QuizMistake({
    required this.word,
    required this.userAnswer,
    required this.correctAnswer,
  });
}

class QuizState {
  final List<QuizQuestion> questions;
  final int currentIndex;
  final bool isCompleted;
  final int correctCount;
  final int wrongCount;
  final List<QuizMistake> mistakes;

  const QuizState({
    this.questions = const [],
    this.currentIndex = 0,
    this.isCompleted = false,
    this.correctCount = 0,
    this.wrongCount = 0,
    this.mistakes = const [],
  });

  QuizQuestion? get currentQuestion =>
      currentIndex < questions.length ? questions[currentIndex] : null;

  int get totalQuestions => questions.length;

  double get progress => totalQuestions > 0
      ? (currentIndex / totalQuestions).clamp(0.0, 1.0)
      : 0.0;

  double get accuracy =>
      totalQuestions > 0 ? (correctCount / totalQuestions) * 100 : 0.0;

  QuizState copyWith({
    List<QuizQuestion>? questions,
    int? currentIndex,
    bool? isCompleted,
    int? correctCount,
    int? wrongCount,
    List<QuizMistake>? mistakes,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      mistakes: mistakes ?? this.mistakes,
    );
  }
}

class QuizNotifier extends AutoDisposeNotifier<QuizState> {
  @override
  QuizState build() => const QuizState();

  void startQuiz({required List<Vocabulary> pool, int questionCount = 5}) {
    if (pool.isEmpty) {
      state = const QuizState(isCompleted: true);
      return;
    }

    final shuffledPool = List<Vocabulary>.from(pool)..shuffle();
    final selectedWords = shuffledPool.take(questionCount).toList();

    final questions = <QuizQuestion>[];

    for (var i = 0; i < selectedWords.length; i++) {
      final target = selectedWords[i];
      // Alternate between Japanese -> Indonesian and Indonesian -> Japanese
      final direction = i % 2 == 0
          ? LearningDirection.jaToId
          : LearningDirection.idToJa;

      final isJaToId = direction == LearningDirection.jaToId;
      final wordDisplay = target.kanji != null
          ? '${target.kanji} (${target.hiragana})'
          : target.hiragana;

      final questionText = isJaToId
          ? 'Apa arti dari "$wordDisplay"?'
          : 'Bagaimana kosakata untuk "${target.meaning}"?';

      final correctAnswer = isJaToId ? target.meaning : target.hiragana;

      // Generate 3 distractors
      final distractors =
          pool
              .where((w) => w.id != target.id)
              .map((w) => isJaToId ? w.meaning : w.hiragana)
              .toSet()
              .toList()
            ..shuffle();

      final options = [correctAnswer, ...distractors.take(3)]..shuffle();

      questions.add(
        QuizQuestion(
          targetWord: target,
          direction: direction,
          questionText: questionText,
          correctAnswer: correctAnswer,
          options: options,
        ),
      );
    }

    state = QuizState(
      questions: questions,
      currentIndex: 0,
      isCompleted: questions.isEmpty,
    );
  }

  Future<void> answer(String selectedOption) async {
    final question = state.currentQuestion;
    if (question == null || question.isAnswered) return;

    final isCorrect = selectedOption == question.correctAnswer;
    final updatedQuestion = question.copyWith(
      selectedAnswer: selectedOption,
      isAnswered: true,
    );

    final updatedQuestions = List<QuizQuestion>.from(state.questions);
    updatedQuestions[state.currentIndex] = updatedQuestion;

    final updatedMistakes = List<QuizMistake>.from(state.mistakes);
    if (!isCorrect) {
      updatedMistakes.add(
        QuizMistake(
          word: question.targetWord,
          userAnswer: selectedOption,
          correctAnswer: question.correctAnswer,
        ),
      );
    }

    // Persist attempt & mistake tracking into database
    final repo = ref.read(practiceRepositoryProvider);
    await repo.recordQuizAttempt(
      vocabularyId: question.targetWord.id,
      direction: question.direction,
      questionType: question.direction == LearningDirection.jaToId
          ? 'multiple_choice'
          : 'reverse_translation',
      userAnswer: selectedOption,
      isCorrect: isCorrect,
    );

    state = state.copyWith(
      questions: updatedQuestions,
      correctCount: state.correctCount + (isCorrect ? 1 : 0),
      wrongCount: state.wrongCount + (isCorrect ? 0 : 1),
      mistakes: updatedMistakes,
    );
  }

  void nextQuestion() {
    final nextIndex = state.currentIndex + 1;
    final isDone = nextIndex >= state.questions.length;

    state = state.copyWith(currentIndex: nextIndex, isCompleted: isDone);
  }
}

final quizControllerProvider =
    NotifierProvider.autoDispose<QuizNotifier, QuizState>(QuizNotifier.new);
