import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/theme/app_theme.dart';
import 'package:kotobaflow/features/practice/presentation/practice_screen.dart';

void main() {
  group('PracticeScreen', () {
    testWidgets(
      'renders Flashcard section, Quiz section, and weak words card',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [weakWordsCountProvider.overrideWith((ref) async => 3)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PracticeScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Check titles & subtitles
        expect(find.text('Pusat Latihan'), findsOneWidget);
        expect(find.text('Pilih Metode Latihan'), findsOneWidget);

        // Check Flashcard card
        expect(find.text('Flashcard Dua Arah'), findsOneWidget);
        expect(find.text('Jepang → ID'), findsOneWidget);
        expect(find.text('ID → Jepang'), findsOneWidget);
        expect(find.text('Mulai Flashcard (10 Kata)'), findsOneWidget);

        // Check Quiz card
        expect(find.text('Quiz Kosakata'), findsOneWidget);
        expect(find.text('5 Soal'), findsOneWidget);
        expect(find.text('10 Soal'), findsOneWidget);
        expect(find.text('Mulai Quiz (5 Soal)'), findsOneWidget);

        // Check Weak Words card with count
        expect(find.text('Evaluasi Kosakata Lemah'), findsOneWidget);
        expect(find.text('3 kosakata perlu diperkuat'), findsOneWidget);
        expect(find.text('Latih'), findsOneWidget);
      },
    );
  });
}
