import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/database/app_database.dart';
import 'package:kotobaflow/features/practice/data/quiz_controller.dart';
import 'package:kotobaflow/features/practice/data/survival_controller.dart';

void main() {
  const sampleWord = Vocabulary(
    id: 'n5_0001',
    kanji: '食べる',
    hiragana: 'たべる',
    romaji: 'taberu',
    meaning: 'Makan',
    wordType: 'Verb',
    verbGroup: 'Group 2',
    exampleJp: 'ご飯を食べます。',
    exampleId: 'Makan nasi.',
    audioPath: null,
    jlptLevel: 'N5',
    isFavorite: false,
  );

  group('SurvivalState', () {
    test('initial state starts with 3 lives and 0 score', () {
      const state = SurvivalState();
      expect(state.lives, 3);
      expect(state.score, 0);
      expect(state.isGameOver, isFalse);
    });

    test('state copyWith updates lives and game over flag correctly', () {
      const state = SurvivalState(lives: 1, score: 5);
      final overState = state.copyWith(lives: 0, isGameOver: true);
      expect(overState.lives, 0);
      expect(overState.isGameOver, isTrue);
      expect(overState.score, 5);
    });

    test('tracks mistakes when answers are incorrect', () {
      const state = SurvivalState(
        mistakes: [
          QuizMistake(
            word: sampleWord,
            userAnswer: 'Minum',
            correctAnswer: 'Makan',
          ),
        ],
      );
      expect(state.mistakes.length, 1);
      expect(state.mistakes.first.correctAnswer, 'Makan');
    });
  });
}
