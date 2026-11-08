import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import 'practice_repository.dart';

/// State of an active flashcard session.
class FlashcardState {
  final List<Vocabulary> words;
  final int currentIndex;
  final LearningDirection direction;
  final bool isFlipped;
  final bool isCompleted;
  final int againCount;
  final int hardCount;
  final int goodCount;
  final int easyCount;

  const FlashcardState({
    this.words = const [],
    this.currentIndex = 0,
    this.direction = LearningDirection.jaToId,
    this.isFlipped = false,
    this.isCompleted = false,
    this.againCount = 0,
    this.hardCount = 0,
    this.goodCount = 0,
    this.easyCount = 0,
  });

  Vocabulary? get currentWord =>
      currentIndex < words.length ? words[currentIndex] : null;

  int get totalWords => words.length;

  int get completedWords => currentIndex;

  double get progress =>
      totalWords > 0 ? (currentIndex / totalWords).clamp(0.0, 1.0) : 0.0;

  FlashcardState copyWith({
    List<Vocabulary>? words,
    int? currentIndex,
    LearningDirection? direction,
    bool? isFlipped,
    bool? isCompleted,
    int? againCount,
    int? hardCount,
    int? goodCount,
    int? easyCount,
  }) {
    return FlashcardState(
      words: words ?? this.words,
      currentIndex: currentIndex ?? this.currentIndex,
      direction: direction ?? this.direction,
      isFlipped: isFlipped ?? this.isFlipped,
      isCompleted: isCompleted ?? this.isCompleted,
      againCount: againCount ?? this.againCount,
      hardCount: hardCount ?? this.hardCount,
      goodCount: goodCount ?? this.goodCount,
      easyCount: easyCount ?? this.easyCount,
    );
  }
}

class FlashcardNotifier extends AutoDisposeNotifier<FlashcardState> {
  @override
  FlashcardState build() => const FlashcardState();

  Future<void> startSession({
    required List<Vocabulary> words,
    LearningDirection direction = LearningDirection.jaToId,
  }) async {
    state = FlashcardState(
      words: words,
      currentIndex: 0,
      direction: direction,
      isFlipped: false,
      isCompleted: words.isEmpty,
    );
  }

  void flipCard() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  Future<void> rateCard(FlashcardRating rating) async {
    final word = state.currentWord;
    if (word == null) return;

    // Persist rating into database
    final repo = ref.read(practiceRepositoryProvider);
    await repo.recordFlashcardResult(
      vocabularyId: word.id,
      direction: state.direction,
      rating: rating,
    );

    // Update counts
    var again = state.againCount;
    var hard = state.hardCount;
    var good = state.goodCount;
    var easy = state.easyCount;

    switch (rating) {
      case FlashcardRating.again:
        again++;
      case FlashcardRating.hard:
        hard++;
      case FlashcardRating.good:
        good++;
      case FlashcardRating.easy:
        easy++;
    }

    final nextIndex = state.currentIndex + 1;
    final isDone = nextIndex >= state.words.length;

    state = state.copyWith(
      currentIndex: nextIndex,
      isFlipped: false,
      isCompleted: isDone,
      againCount: again,
      hardCount: hard,
      goodCount: good,
      easyCount: easy,
    );
  }
}

final flashcardControllerProvider =
    NotifierProvider.autoDispose<FlashcardNotifier, FlashcardState>(
      FlashcardNotifier.new,
    );
