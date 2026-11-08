import '../../features/practice/data/practice_repository.dart';

/// Output calculated by the Spaced Repetition algorithm.
class SrsScheduleResult {
  final DateTime nextReviewAt;
  final String status; // 'learning', 'review', 'mature', 'relearning'
  final int repetitions;
  final int intervalDays;

  const SrsScheduleResult({
    required this.nextReviewAt,
    required this.status,
    required this.repetitions,
    required this.intervalDays,
  });
}

/// Spaced Repetition System (SRS) Engine implementing an adaptive interval algorithm
/// per PRD FR-05.
///
/// Designed to be offline-first, deterministic, and lightweight.
abstract final class SrsEngine {
  /// Calculates the next review date and updated learning status based on the user's
  /// self-assessment rating.
  static SrsScheduleResult calculateNextReview({
    required FlashcardRating rating,
    required int currentRepetitions,
    required String currentStatus,
    DateTime? fromTime,
  }) {
    final now = fromTime ?? DateTime.now();

    switch (rating) {
      case FlashcardRating.again:
        // Immediate review in 10 minutes; reset repetitions or flag as relearning
        return SrsScheduleResult(
          nextReviewAt: now.add(const Duration(minutes: 10)),
          status: 'relearning',
          repetitions: 0,
          intervalDays: 0,
        );

      case FlashcardRating.hard:
        // Needs reinforcement tomorrow
        final interval = currentRepetitions == 0 ? 1 : 1;
        return SrsScheduleResult(
          nextReviewAt: now.add(Duration(days: interval)),
          status: 'learning',
          repetitions: currentRepetitions + 1,
          intervalDays: interval,
        );

      case FlashcardRating.good:
        // Normal progression: 1 day -> 3 days -> 7 days -> 16 days
        final int interval;
        if (currentRepetitions == 0) {
          interval = 1;
        } else if (currentRepetitions == 1) {
          interval = 3;
        } else {
          interval = (currentRepetitions * 2.5).round().clamp(5, 60);
        }

        final status = interval >= 7 ? 'mature' : 'review';

        return SrsScheduleResult(
          nextReviewAt: now.add(Duration(days: interval)),
          status: status,
          repetitions: currentRepetitions + 1,
          intervalDays: interval,
        );

      case FlashcardRating.easy:
        // Accelerated interval: 3 days -> 7 days -> 14 days
        final int interval;
        if (currentRepetitions == 0) {
          interval = 3;
        } else {
          interval = ((currentRepetitions + 1) * 3.5).round().clamp(7, 90);
        }

        return SrsScheduleResult(
          nextReviewAt: now.add(Duration(days: interval)),
          status: 'mature',
          repetitions: currentRepetitions + 1,
          intervalDays: interval,
        );
    }
  }

  /// Categorizes an item's current mastery badge.
  static String getStatusLabel(String status) {
    switch (status) {
      case 'mature':
        return 'Stabil / Dikuasai';
      case 'review':
        return 'Perlu Diulang';
      case 'learning':
        return 'Sedang Dipelajari';
      case 'relearning':
        return 'Dipelajari Ulang';
      case 'new':
      default:
        return 'Kosakata Baru';
    }
  }
}
