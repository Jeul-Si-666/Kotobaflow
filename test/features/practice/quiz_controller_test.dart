import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/database/app_database.dart';
import 'package:kotobaflow/features/practice/data/practice_repository.dart';
import 'package:kotobaflow/features/practice/data/quiz_controller.dart';

void main() {
  const sampleWord1 = Vocabulary(
    id: 'n5_0001',
    kanji: '食べる',
    hiragana: 'たべる',
    romaji: 'taberu',
    meaning: 'Makan',
    wordType: 'Verb',
    verbGroup: 'Group 2 (Ichidan)',
    exampleJp: '毎朝パンを食べます。',
    exampleId: 'Setiap pagi saya makan roti.',
    audioPath: null,
    jlptLevel: 'N5',
    isFavorite: false,
  );

  const sampleWord2 = Vocabulary(
    id: 'n5_0005',
    kanji: '飲む',
    hiragana: 'のむ',
    romaji: 'nomu',
    meaning: 'Minum',
    wordType: 'Verb',
    verbGroup: 'Group 1 (Godan)',
    exampleJp: 'お水を飲みます。',
    exampleId: 'Saya minum air.',
    audioPath: null,
    jlptLevel: 'N5',
    isFavorite: false,
  );

  group('QuizQuestion & QuizState', () {
    test('QuizQuestion correctly evaluates answer match', () {
      final question = QuizQuestion(
        targetWord: sampleWord1,
        direction: LearningDirection.jaToId,
        questionText: 'Apa arti dari 食べる?',
        correctAnswer: 'Makan',
        options: ['Makan', 'Minum', 'Tidur', 'Bangun'],
        selectedAnswer: 'Makan',
        isAnswered: true,
      );

      expect(question.isCorrect, isTrue);

      final wrongQuestion = question.copyWith(
        selectedAnswer: 'Minum',
        isAnswered: true,
      );
      expect(wrongQuestion.isCorrect, isFalse);
    });

    test(
      'QuizState accuracy calculation handles empty and completed sessions',
      () {
        const stateEmpty = QuizState();
        expect(stateEmpty.accuracy, 0.0);

        const statePartial = QuizState(
          questions: [
            QuizQuestion(
              targetWord: sampleWord1,
              direction: LearningDirection.jaToId,
              questionText: 'Q1',
              correctAnswer: 'A',
              options: ['A', 'B'],
            ),
            QuizQuestion(
              targetWord: sampleWord2,
              direction: LearningDirection.jaToId,
              questionText: 'Q2',
              correctAnswer: 'C',
              options: ['C', 'D'],
            ),
          ],
          correctCount: 1,
          wrongCount: 1,
        );

        expect(statePartial.accuracy, 50.0);
      },
    );
  });
}
