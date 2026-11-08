import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';

/// Data model representing the aggregated metrics for the Home Dashboard.
class HomeDashboardData {
  final int streakDays;
  final int wordsStudiedToday;
  final int dailyGoal;
  final int dueReviewCount;
  final int totalMasteredCount;
  final int totalVocabCount;
  final double todayAccuracy;

  const HomeDashboardData({
    this.streakDays = 0,
    this.wordsStudiedToday = 0,
    this.dailyGoal = 10,
    this.dueReviewCount = 0,
    this.totalMasteredCount = 0,
    this.totalVocabCount = 0,
    this.todayAccuracy = 0.0,
  });

  double get progressRatio =>
      dailyGoal > 0 ? (wordsStudiedToday / dailyGoal).clamp(0.0, 1.0) : 0.0;
}

/// Provider that calculates current metrics directly from the local SQLite database.
final homeDashboardProvider = FutureProvider<HomeDashboardData>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final todayStr = DateTime.now().toIso8601String().substring(0, 10);

  // 1. Today's daily activity
  final todayActivity = await (db.select(
    db.dailyActivities,
  )..where((tbl) => tbl.date.equals(todayStr))).getSingleOrNull();

  // 2. Count due reviews (nextReviewAt <= now or status == 'review' or status == 'relearning')
  final nowIso = DateTime.now().toIso8601String();
  final dueReviews =
      await (db.select(db.learningProgresses)..where(
            (tbl) =>
                tbl.nextReviewAt.isSmallerOrEqualValue(nowIso) |
                tbl.status.equals('review') |
                tbl.status.equals('relearning'),
          ))
          .get();

  // 3. Total vocabulary count
  final vocabList = await db.select(db.vocabularies).get();

  // 4. Mastered count (status == 'mature')
  final mastered = await (db.select(
    db.learningProgresses,
  )..where((tbl) => tbl.status.equals('mature'))).get();

  final wordsStudied = todayActivity?.wordsStudied ?? 0;
  final totalAnswers =
      (todayActivity?.correctAnswers ?? 0) + (todayActivity?.wrongAnswers ?? 0);
  final accuracy = totalAnswers > 0
      ? (todayActivity!.correctAnswers / totalAnswers) * 100
      : 0.0;

  return HomeDashboardData(
    streakDays: wordsStudied > 0 ? 1 : 0,
    wordsStudiedToday: wordsStudied,
    dailyGoal: 10,
    dueReviewCount: dueReviews.length,
    totalMasteredCount: mastered.length,
    totalVocabCount: vocabList.length,
    todayAccuracy: accuracy,
  );
});
