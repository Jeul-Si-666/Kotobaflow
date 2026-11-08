import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/practice_repository.dart';

/// Provider for counting weak vocabularies in the database.
final weakWordsCountProvider = FutureProvider.autoDispose<int>((ref) async {
  final repo = ref.watch(practiceRepositoryProvider);
  final weakList = await repo.getWeakVocabularies();
  return weakList.length;
});

/// Practice Hub screen providing options for Two-way Flashcards and Quiz Engine.
class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key});

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  LearningDirection _flashcardDirection = LearningDirection.jaToId;
  int _quizQuestionCount = 5;

  @override
  Widget build(BuildContext context) {
    final weakCountAsync = ref.watch(weakWordsCountProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Latihan'),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Metode Latihan',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Latih daya ingat secara bertahap dan konsisten.',
                style: theme.textTheme.bodySmall,
              ),

              const SizedBox(height: 20),

              // ── 1. Flashcard Feature Card ────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.flip_rounded,
                            color: colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Flashcard Dua Arah',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Kartu bolak-balik dengan penilaian mandiri',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Direction Selector (FR-02)
                    Text(
                      'Arah Latihan:',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<LearningDirection>(
                      segments: const [
                        ButtonSegment(
                          value: LearningDirection.jaToId,
                          label: Text('Jepang → ID'),
                          icon: Icon(Icons.arrow_forward_rounded, size: 16),
                        ),
                        ButtonSegment(
                          value: LearningDirection.idToJa,
                          label: Text('ID → Jepang'),
                          icon: Icon(Icons.arrow_back_rounded, size: 16),
                        ),
                      ],
                      selected: {_flashcardDirection},
                      onSelectionChanged: (selected) {
                        setState(() {
                          _flashcardDirection = selected.first;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          context.go(
                            '/practice/flashcard?direction=${_flashcardDirection.value}',
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Mulai Flashcard (10 Kata)'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── 2. Quiz Engine Feature Card ──────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.quiz_outlined,
                            color: colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quiz Kosakata',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Pilihan ganda dengan evaluasi langsung',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Question Count Selector
                    Text(
                      'Jumlah Soal:',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 5, label: Text('5 Soal')),
                        ButtonSegment(value: 10, label: Text('10 Soal')),
                      ],
                      selected: {_quizQuestionCount},
                      onSelectionChanged: (selected) {
                        setState(() {
                          _quizQuestionCount = selected.first;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          context.go(
                            '/practice/quiz?count=$_quizQuestionCount',
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: Text('Mulai Quiz ($_quizQuestionCount Soal)'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── 3. Survival Mode Card (3 Nyawa) ──────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tantangan Bertahan',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      '3 Nyawa',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Menebak terus-menerus tanpa henti. Salah 3x permainan berakhir!',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                        ),
                        onPressed: () {
                          context.go('/practice/survival');
                        },
                        icon: const Icon(Icons.flash_on_rounded),
                        label: const Text('Mulai Tebak Beruntun (3 Nyawa)'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── 4. Mistake Review Card (FR-04) ───────────────────────────
              weakCountAsync.when(
                data: (count) {
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: count > 0
                          ? colorScheme.error.withValues(alpha: 0.08)
                          : colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: count > 0
                            ? colorScheme.error.withValues(alpha: 0.3)
                            : theme.dividerColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: count > 0
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                          size: 26,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Evaluasi Kosakata Lemah',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                count > 0
                                    ? '$count kosakata perlu diperkuat'
                                    : 'Belum ada kosakata yang sering salah',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        if (count > 0)
                          OutlinedButton(
                            onPressed: () {
                              context.go('/practice/flashcard');
                            },
                            child: const Text('Latih'),
                          ),
                      ],
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
