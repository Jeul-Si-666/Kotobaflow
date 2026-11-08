import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/widgets/furigana_text.dart';
import '../data/vocabulary_repository.dart';

/// Provider for learning progress on a specific vocabulary.
final vocabularyProgressProvider = FutureProvider.family
    .autoDispose<List<LearningProgressesData>, String>((ref, id) {
      final repo = ref.watch(vocabularyRepositoryProvider);
      return repo.getProgressForVocabulary(id);
    });

/// Detailed view of a single vocabulary entry.
class WordDetailScreen extends ConsumerWidget {
  const WordDetailScreen({super.key, required this.vocabularyId});

  final String vocabularyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordAsync = ref.watch(vocabularyDetailProvider(vocabularyId));
    final progressAsync = ref.watch(vocabularyProgressProvider(vocabularyId));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kosakata'),
        actions: [
          wordAsync.maybeWhen(
            data: (word) {
              if (word == null) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(
                  word.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: word.isFavorite ? colorScheme.primary : null,
                ),
                onPressed: () async {
                  await ref
                      .read(vocabularyRepositoryProvider)
                      .toggleFavorite(word.id);
                  ref.invalidate(vocabularyDetailProvider(word.id));
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: wordAsync.when(
          data: (word) {
            if (word == null) {
              return const Center(child: Text('Kosakata tidak ditemukan.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Hero Card ─────────────────────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 28,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Column(
                          children: [
                            // Level badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                word.jlptLevel,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Large Furigana Text
                            FuriganaText(
                              kanji: word.kanji,
                              reading: word.hiragana,
                              mainTextStyle: theme.textTheme.headlineLarge
                                  ?.copyWith(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),

                            if (word.romaji != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                word.romaji!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],

                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),

                            // Meaning
                            Text(
                              word.meaning,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 10),

                            // Type & Group tag
                            Text(
                              word.verbGroup != null
                                  ? '${word.wordType} · ${word.verbGroup}'
                                  : word.wordType,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Example Sentence Card ─────────────────────────────
                      if (word.exampleJp != null) ...[
                        Text(
                          'Contoh Kalimat',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                word.exampleJp!,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                              ),
                              if (word.exampleId != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  word.exampleId!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // ── Learning Progress Card ─────────────────────────────
                      Text(
                        'Statistik Pembelajaran',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: progressAsync.when(
                          data: (progressList) {
                            if (progressList.isEmpty) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.school_outlined,
                                    size: 20,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Belum pernah dipelajari. Mulai latihan di menu Practice untuk melacak progres kata ini.',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Column(
                              children: progressList.map((p) {
                                final directionLabel = p.direction == 'ja_to_id'
                                    ? 'Jepang → Indonesia'
                                    : 'Indonesia → Jepang';
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        directionLabel,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      Text(
                                        'Benar: ${p.correctCount} | Salah: ${p.wrongCount}',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (_, __) => const Text('Gagal memuat status'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
