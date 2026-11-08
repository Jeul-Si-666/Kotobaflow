import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/widgets/furigana_text.dart';
import '../data/vocabulary_repository.dart';

/// Vocabulary Library screen with real-time search, category filtering, and favorite toggle.
class VocabularyScreen extends ConsumerStatefulWidget {
  const VocabularyScreen({super.key});

  @override
  ConsumerState<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends ConsumerState<VocabularyScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final initialQuery = ref.read(vocabularyFilterProvider).searchQuery;
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vocabulariesAsync = ref.watch(filteredVocabulariesProvider);
    final filterState = ref.watch(vocabularyFilterProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Koleksi Kosakata N5'),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Search Bar ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari kanji, hiragana, romaji, atau arti...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(vocabularyFilterProvider.notifier)
                                .setSearchQuery('');
                          },
                        )
                      : null,
                ),
                onChanged: (val) {
                  ref
                      .read(vocabularyFilterProvider.notifier)
                      .setSearchQuery(val);
                },
              ),
            ),

            // ── Filter Chips ───────────────────────────────────────────────
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CategoryChip(
                    label: 'Semua',
                    isSelected:
                        filterState.selectedCategory == 'Semua' &&
                        !filterState.onlyFavorites,
                    onSelected: () {
                      ref
                          .read(vocabularyFilterProvider.notifier)
                          .setCategory('Semua');
                      if (filterState.onlyFavorites) {
                        ref
                            .read(vocabularyFilterProvider.notifier)
                            .toggleFavoritesOnly();
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Kata Kerja',
                    isSelected: filterState.selectedCategory == 'Verb',
                    onSelected: () {
                      ref
                          .read(vocabularyFilterProvider.notifier)
                          .setCategory('Verb');
                    },
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Kata Benda',
                    isSelected: filterState.selectedCategory == 'Noun',
                    onSelected: () {
                      ref
                          .read(vocabularyFilterProvider.notifier)
                          .setCategory('Noun');
                    },
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Kata Sifat',
                    isSelected: filterState.selectedCategory == 'Adjective',
                    onSelected: () {
                      ref
                          .read(vocabularyFilterProvider.notifier)
                          .setCategory('Adjective');
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          filterState.onlyFavorites
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 16,
                          color: filterState.onlyFavorites
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        const Text('Favorit'),
                      ],
                    ),
                    selected: filterState.onlyFavorites,
                    onSelected: (_) {
                      ref
                          .read(vocabularyFilterProvider.notifier)
                          .toggleFavoritesOnly();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // ── Word List ──────────────────────────────────────────────────
            Expanded(
              child: vocabulariesAsync.when(
                data: (words) {
                  if (words.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Tidak ada kosakata yang cocok',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Coba kata kunci atau filter lain',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Menampilkan ${words.length} kosakata N5',
                              style: theme.textTheme.labelSmall,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Offline DB',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: words.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final word = words[index];
                            return _VocabularyCard(
                              vocabulary: word,
                              onTap: () => context.go('/vocabulary/${word.id}'),
                              onFavoriteToggle: () {
                                ref
                                    .read(vocabularyRepositoryProvider)
                                    .toggleFavorite(word.id);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) =>
                    Center(child: Text('Gagal memuat kosakata: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class _VocabularyCard extends StatelessWidget {
  const _VocabularyCard({
    required this.vocabulary,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  final Vocabulary vocabulary;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Japanese representation with Furigana
              SizedBox(
                width: 90,
                child: FuriganaText(
                  kanji: vocabulary.kanji,
                  reading: vocabulary.hiragana,
                  mainTextStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Meaning & Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vocabulary.meaning,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (vocabulary.romaji != null) ...[
                          Text(
                            vocabulary.romaji!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            vocabulary.wordType,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Favorite Star Button
              IconButton(
                icon: Icon(
                  vocabulary.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: vocabulary.isFavorite
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                onPressed: onFavoriteToggle,
                tooltip: vocabulary.isFavorite
                    ? 'Hapus dari favorit'
                    : 'Tambah ke favorit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
