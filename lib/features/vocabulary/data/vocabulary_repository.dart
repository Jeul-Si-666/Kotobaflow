import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';

/// Repository handling all Vocabulary data queries and operations.
class VocabularyRepository {
  final AppDatabase _db;

  VocabularyRepository(this._db);

  /// Watches all vocabularies matching the optional [searchQuery], [wordTypeFilter],
  /// and [onlyFavorites] criteria.
  Stream<List<Vocabulary>> watchVocabularies({
    String? searchQuery,
    String? wordTypeFilter,
    bool onlyFavorites = false,
  }) {
    final query = _db.select(_db.vocabularies);

    query.where((tbl) {
      final conditions = <Expression<bool>>[];

      // 1. Search Query across Kanji, Hiragana, Romaji, and Meaning
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final pattern = '%${searchQuery.trim().toLowerCase()}%';
        conditions.add(
          tbl.meaning.lower().like(pattern) |
              tbl.hiragana.lower().like(pattern) |
              tbl.kanji.lower().like(pattern) |
              tbl.romaji.lower().like(pattern),
        );
      }

      // 2. Word Type Filter (e.g. 'Verb', 'Noun', 'Adjective')
      if (wordTypeFilter != null && wordTypeFilter != 'Semua') {
        if (wordTypeFilter == 'Adjective') {
          conditions.add(
            tbl.wordType.equals('Adjective-i') |
                tbl.wordType.equals('Adjective-na'),
          );
        } else {
          conditions.add(tbl.wordType.equals(wordTypeFilter));
        }
      }

      // 3. Favorites only filter
      if (onlyFavorites) {
        conditions.add(tbl.isFavorite.equals(true));
      }

      if (conditions.isEmpty) {
        return const Constant(true);
      }

      return conditions.reduce((a, b) => a & b);
    });

    query.orderBy([
      (tbl) => OrderingTerm(expression: tbl.id, mode: OrderingMode.asc),
    ]);

    return query.watch();
  }

  /// Retrieves a single vocabulary entry by its unique [id].
  Future<Vocabulary?> getVocabularyById(String id) {
    return (_db.select(
      _db.vocabularies,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Toggles the favorite status of a vocabulary item.
  Future<void> toggleFavorite(String id) async {
    final item = await getVocabularyById(id);
    if (item == null) return;

    await (_db.update(_db.vocabularies)..where((tbl) => tbl.id.equals(id)))
        .write(VocabulariesCompanion(isFavorite: Value(!item.isFavorite)));
  }

  /// Retrieves learning progress records for a given vocabulary [id].
  Future<List<LearningProgressesData>> getProgressForVocabulary(String id) {
    return (_db.select(
      _db.learningProgresses,
    )..where((tbl) => tbl.vocabularyId.equals(id))).get();
  }
}

/// Provider for [VocabularyRepository].
final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return VocabularyRepository(db);
});

// ── Search & Filter State ─────────────────────────────────────────────────────

class VocabularyFilterState {
  final String searchQuery;
  final String selectedCategory; // 'Semua', 'Verb', 'Noun', 'Adjective', etc.
  final bool onlyFavorites;

  const VocabularyFilterState({
    this.searchQuery = '',
    this.selectedCategory = 'Semua',
    this.onlyFavorites = false,
  });

  VocabularyFilterState copyWith({
    String? searchQuery,
    String? selectedCategory,
    bool? onlyFavorites,
  }) {
    return VocabularyFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
    );
  }
}

class VocabularyFilterNotifier extends Notifier<VocabularyFilterState> {
  @override
  VocabularyFilterState build() => const VocabularyFilterState();

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void toggleFavoritesOnly() {
    state = state.copyWith(onlyFavorites: !state.onlyFavorites);
  }
}

final vocabularyFilterProvider =
    NotifierProvider<VocabularyFilterNotifier, VocabularyFilterState>(
      VocabularyFilterNotifier.new,
    );

/// StreamProvider that reactively emits filtered vocabularies based on active filter state.
final filteredVocabulariesProvider =
    StreamProvider.autoDispose<List<Vocabulary>>((ref) {
      final repo = ref.watch(vocabularyRepositoryProvider);
      final filter = ref.watch(vocabularyFilterProvider);

      return repo.watchVocabularies(
        searchQuery: filter.searchQuery,
        wordTypeFilter: filter.selectedCategory,
        onlyFavorites: filter.onlyFavorites,
      );
    });

/// FutureProvider that fetches a single word's details by ID.
final vocabularyDetailProvider = FutureProvider.family
    .autoDispose<Vocabulary?, String>((ref, id) {
      final repo = ref.watch(vocabularyRepositoryProvider);
      return repo.getVocabularyById(id);
    });
