import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/database/app_database.dart';
import 'package:kotobaflow/core/theme/app_theme.dart';
import 'package:kotobaflow/features/vocabulary/data/vocabulary_repository.dart';
import 'package:kotobaflow/features/vocabulary/presentation/vocabulary_screen.dart';

void main() {
  const sampleWord1 = Vocabulary(
    id: 'n5_0001',
    kanji: '食べる',
    hiragana: 'たべる',
    romaji: 'taberu',
    meaning: 'Makan',
    wordType: 'Verb',
    verbGroup: 'Group 2 (Ichidan)',
    exampleJp: 'ご飯を食べます。',
    exampleId: 'Saya makan nasi.',
    audioPath: null,
    jlptLevel: 'N5',
    isFavorite: false,
  );

  const sampleWord2 = Vocabulary(
    id: 'n5_0014',
    kanji: '本',
    hiragana: 'ほん',
    romaji: 'hon',
    meaning: 'Buku',
    wordType: 'Noun',
    verbGroup: null,
    exampleJp: '本を読みます。',
    exampleId: 'Membaca buku.',
    audioPath: null,
    jlptLevel: 'N5',
    isFavorite: true,
  );

  group('VocabularyScreen', () {
    testWidgets('renders search bar, filter chips, and vocabulary list', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredVocabulariesProvider.overrideWith(
              (ref) => Stream.value([sampleWord1, sampleWord2]),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const VocabularyScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check App bar
      expect(find.text('Koleksi Kosakata N5'), findsOneWidget);

      // Check Search bar hint
      expect(
        find.text('Cari kanji, hiragana, romaji, atau arti...'),
        findsOneWidget,
      );

      // Check Filter chips
      expect(find.text('Semua'), findsOneWidget);
      expect(find.text('Kata Kerja'), findsOneWidget);
      expect(find.text('Kata Benda'), findsOneWidget);
      expect(find.text('Kata Sifat'), findsOneWidget);
      expect(find.text('Favorit'), findsOneWidget);

      // Check Vocabulary card 1
      expect(find.text('食べる'), findsOneWidget);
      expect(find.text('たべる'), findsOneWidget);
      expect(find.text('Makan'), findsOneWidget);
      expect(find.text('taberu'), findsOneWidget);

      // Check Vocabulary card 2
      expect(find.text('本'), findsOneWidget);
      expect(find.text('ほん'), findsOneWidget);
      expect(find.text('Buku'), findsOneWidget);
    });

    testWidgets('displays empty state when no words found', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredVocabulariesProvider.overrideWith(
              (ref) => Stream.value([]),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const VocabularyScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Tidak ada kosakata yang cocok'), findsOneWidget);
      expect(find.text('Coba kata kunci atau filter lain'), findsOneWidget);
    });
  });
}
