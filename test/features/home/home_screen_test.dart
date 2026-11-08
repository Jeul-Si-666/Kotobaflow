import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/theme/app_theme.dart';
import 'package:kotobaflow/features/home/data/home_dashboard_provider.dart';
import 'package:kotobaflow/features/home/presentation/home_screen.dart';

void main() {
  group('HomeDashboardData', () {
    test('progressRatio calculates accurately and clamps to 1.0', () {
      const dataZero = HomeDashboardData(wordsStudiedToday: 0, dailyGoal: 10);
      expect(dataZero.progressRatio, 0.0);

      const dataHalf = HomeDashboardData(wordsStudiedToday: 5, dailyGoal: 10);
      expect(dataHalf.progressRatio, 0.5);

      const dataOver = HomeDashboardData(wordsStudiedToday: 15, dailyGoal: 10);
      expect(dataOver.progressRatio, 1.0);
    });
  });

  group('HomeScreen Widget', () {
    testWidgets('renders header, greeting, progress card, and activity cards', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeDashboardProvider.overrideWith(
              (ref) async => const HomeDashboardData(
                streakDays: 3,
                wordsStudiedToday: 4,
                dailyGoal: 10,
                dueReviewCount: 2,
                totalMasteredCount: 15,
                todayAccuracy: 80.0,
              ),
            ),
          ],
          child: MaterialApp(theme: AppTheme.light(), home: const HomeScreen()),
        ),
      );

      // Pump through async loading
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.text('KotobaFlow'), findsOneWidget);
      expect(find.text('言葉を、自然に。'), findsOneWidget);
      expect(find.text('3 Hari'), findsOneWidget);

      // Verify Greeting
      expect(find.text('こんにちは'), findsOneWidget);

      // Verify Daily Progress card metrics
      expect(find.text('Target Belajar Hari Ini'), findsOneWidget);
      expect(find.text('4/10 Kata'), findsOneWidget);
      expect(find.text('2 kata'), findsOneWidget); // Due reviews
      expect(find.text('80%'), findsOneWidget); // Accuracy
      expect(find.text('15 kata'), findsOneWidget); // Mastered

      // Verify CTA
      expect(find.text('Mulai Review Harian (2 Kata)'), findsOneWidget);

      // Verify Quick Practice Cards
      expect(find.text('Flashcard'), findsOneWidget);
      expect(find.text('Quiz'), findsOneWidget);
      expect(find.text('Koleksi Kosakata JLPT N5'), findsOneWidget);
    });
  });
}
