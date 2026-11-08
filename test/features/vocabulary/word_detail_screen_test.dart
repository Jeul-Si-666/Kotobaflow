import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/database/app_database.dart';
import 'package:kotobaflow/core/theme/app_theme.dart';
import 'package:kotobaflow/features/vocabulary/data/vocabulary_repository.dart';
import 'package:kotobaflow/features/vocabulary/presentation/word_detail_screen.dart';

void main() {
  const sampleWord = Vocabulary(
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

  group('WordDetailScreen', () {
    testWidgets('renders all word attributes, examples, and progress card', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            vocabularyDetailProvider(
              'n5_0001',
            ).overrideWith((ref) async => sampleWord),
            vocabularyProgressProvider(
              'n5_0001',
            ).overrideWith((ref) async => []),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const WordDetailScreen(vocabularyId: 'n5_0001'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Detail Kosakata'), findsOneWidget);
      expect(find.text('N5'), findsOneWidget);
      expect(find.text('食べる'), findsOneWidget);
      expect(find.text('たべる'), findsOneWidget);
      expect(find.text('taberu'), findsOneWidget);
      expect(find.text('Makan'), findsOneWidget);
      expect(find.text('Verb · Group 2 (Ichidan)'), findsOneWidget);

      // Example sentence
      expect(find.text('Contoh Kalimat'), findsOneWidget);
      expect(find.text('毎朝パンを食べます。'), findsOneWidget);
      expect(find.text('Setiap pagi saya makan roti.'), findsOneWidget);

      // Progress section
      expect(find.text('Statistik Pembelajaran'), findsOneWidget);
      expect(find.textContaining('Belum pernah dipelajari'), findsOneWidget);
    });
  });
}
