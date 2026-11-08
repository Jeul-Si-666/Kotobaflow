import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/srs/srs_engine.dart';

/// Enumeration of flashcard self-assessment ratings per FR-02.
enum FlashcardRating {
  again, // Belum ingat
  hard, // Masih sulit
  good, // Sudah ingat
  easy, // Sangat mudah
}

/// Learning direction per FR-04 business rule:
/// Japanese → Indonesian and Indonesian → Japanese are tracked independently.
enum LearningDirection {
  jaToId('ja_to_id'),
  idToJa('id_to_ja');

  final String value;
  const LearningDirection(this.value);
}

/// Repository responsible for persisting practice results, updating mistake tracking,
/// and updating daily learning activities.
class PracticeRepository {
  final AppDatabase _db;

  PracticeRepository(this._db);

  /// Records the result of a flashcard review for a specific [vocabularyId] and [direction].
  ///
  /// Updates `LearningProgresses` and increments today's `DailyActivities`.
  Future<void> recordFlashcardResult({
    required String vocabularyId,
    required LearningDirection direction,
    required FlashcardRating rating,
  }) async {
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final isCorrect =
        rating == FlashcardRating.good || rating == FlashcardRating.easy;

    // 1. Query existing learning progress for this word & direction
    final existingProgress =
        await (_db.select(_db.learningProgresses)..where(
              (tbl) =>
                  tbl.vocabularyId.equals(vocabularyId) &
                  tbl.direction.equals(direction.value),
            ))
            .getSingleOrNull();

    // 2. Calculate next review interval via SRS engine (PRD FR-05)
    final srs = SrsEngine.calculateNextReview(
      rating: rating,
      currentRepetitions: existingProgress?.repetitions ?? 0,
      currentStatus: existingProgress?.status ?? 'new',
      fromTime: now,
    );
    final nextReviewIso = srs.nextReviewAt.toIso8601String();

    if (existingProgress == null) {
      // First time practiced in this direction
      await _db
          .into(_db.learningProgresses)
          .insert(
            LearningProgressesCompanion.insert(
              vocabularyId: vocabularyId,
              direction: direction.value,
              status: Value(srs.status),
              repetitions: Value(srs.repetitions),
              correctCount: Value(isCorrect ? 1 : 0),
              wrongCount: Value(isCorrect ? 0 : 1),
              nextReviewAt: Value(nextReviewIso),
              lastReviewedAt: Value(nowIso),
            ),
          );
    } else {
      // Update existing record
      await (_db.update(
        _db.learningProgresses,
      )..where((tbl) => tbl.id.equals(existingProgress.id))).write(
        LearningProgressesCompanion(
          status: Value(srs.status),
          repetitions: Value(srs.repetitions),
          correctCount: Value(
            existingProgress.correctCount + (isCorrect ? 1 : 0),
          ),
          wrongCount: Value(existingProgress.wrongCount + (isCorrect ? 0 : 1)),
          nextReviewAt: Value(nextReviewIso),
          lastReviewedAt: Value(nowIso),
        ),
      );
    }

    // 3. Log attempt
    await _db
        .into(_db.quizAttempts)
        .insert(
          QuizAttemptsCompanion.insert(
            vocabularyId: vocabularyId,
            questionType: 'flashcard_${direction.value}',
            userAnswer: rating.name,
            isCorrect: isCorrect,
            attemptedAt: nowIso,
          ),
        );

    // 4. Update today's daily activities
    await _incrementDailyActivity(isCorrect: isCorrect);
  }

  /// Records a quiz answer attempt and updates learning progress accordingly.
  Future<void> recordQuizAttempt({
    required String vocabularyId,
    required LearningDirection direction,
    required String questionType,
    required String userAnswer,
    required bool isCorrect,
  }) async {
    final now = DateTime.now();
    final nowIso = now.toIso8601String();

    // 1. Log attempt
    await _db
        .into(_db.quizAttempts)
        .insert(
          QuizAttemptsCompanion.insert(
            vocabularyId: vocabularyId,
            questionType: questionType,
            userAnswer: userAnswer,
            isCorrect: isCorrect,
            attemptedAt: nowIso,
          ),
        );

    // 2. Update learning progress for this word & direction
    final existing =
        await (_db.select(_db.learningProgresses)..where(
              (tbl) =>
                  tbl.vocabularyId.equals(vocabularyId) &
                  tbl.direction.equals(direction.value),
            ))
            .getSingleOrNull();

    final status = isCorrect ? 'review' : 'relearning';
    final interval = isCorrect
        ? const Duration(days: 2)
        : const Duration(hours: 1);
    final nextReviewIso = now.add(interval).toIso8601String();

    if (existing == null) {
      await _db
          .into(_db.learningProgresses)
          .insert(
            LearningProgressesCompanion.insert(
              vocabularyId: vocabularyId,
              direction: direction.value,
              status: Value(status),
              repetitions: const Value(1),
              correctCount: Value(isCorrect ? 1 : 0),
              wrongCount: Value(isCorrect ? 0 : 1),
              nextReviewAt: Value(nextReviewIso),
              lastReviewedAt: Value(nowIso),
            ),
          );
    } else {
      await (_db.update(
        _db.learningProgresses,
      )..where((tbl) => tbl.id.equals(existing.id))).write(
        LearningProgressesCompanion(
          status: Value(status),
          repetitions: Value(existing.repetitions + 1),
          correctCount: Value(existing.correctCount + (isCorrect ? 1 : 0)),
          wrongCount: Value(existing.wrongCount + (isCorrect ? 0 : 1)),
          nextReviewAt: Value(nextReviewIso),
          lastReviewedAt: Value(nowIso),
        ),
      );
    }

    // 3. Update daily activity
    await _incrementDailyActivity(isCorrect: isCorrect);
  }

  /// Fetches a randomized list of vocabularies for practice sessions.
  Future<List<Vocabulary>> getPracticeVocabularies({int limit = 10}) async {
    final all = await _db.select(_db.vocabularies).get();
    final shuffled = List<Vocabulary>.from(all)..shuffle();
    return shuffled.take(limit).toList();
  }

  /// Fetches weak vocabularies (where wrongCount > correctCount or status is 'relearning').
  Future<List<Vocabulary>> getWeakVocabularies({int limit = 10}) async {
    final query = _db.select(_db.learningProgresses)
      ..where(
        (tbl) =>
            tbl.wrongCount.isBiggerThan(tbl.correctCount) |
            tbl.status.equals('relearning'),
      )
      ..limit(limit);

    final weakProgressList = await query.get();
    final weakIds = weakProgressList.map((p) => p.vocabularyId).toSet();

    if (weakIds.isEmpty) return [];

    return (_db.select(
      _db.vocabularies,
    )..where((tbl) => tbl.id.isIn(weakIds))).get();
  }

  Future<void> _incrementDailyActivity({required bool isCorrect}) async {
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    final existing = await (_db.select(
      _db.dailyActivities,
    )..where((tbl) => tbl.date.equals(todayStr))).getSingleOrNull();

    if (existing == null) {
      await _db
          .into(_db.dailyActivities)
          .insert(
            DailyActivitiesCompanion.insert(
              date: todayStr,
              wordsStudied: const Value(1),
              correctAnswers: Value(isCorrect ? 1 : 0),
              wrongAnswers: Value(isCorrect ? 0 : 1),
              studyDurationSeconds: const Value(30),
            ),
          );
    } else {
      await (_db.update(
        _db.dailyActivities,
      )..where((tbl) => tbl.date.equals(todayStr))).write(
        DailyActivitiesCompanion(
          wordsStudied: Value(existing.wordsStudied + 1),
          correctAnswers: Value(existing.correctAnswers + (isCorrect ? 1 : 0)),
          wrongAnswers: Value(existing.wrongAnswers + (isCorrect ? 0 : 1)),
          studyDurationSeconds: Value(existing.studyDurationSeconds + 30),
        ),
      );
    }
  }
}

/// Provider for [PracticeRepository].
final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PracticeRepository(db);
});
