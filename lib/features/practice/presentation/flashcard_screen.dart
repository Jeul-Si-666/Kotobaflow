import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/widgets/furigana_text.dart';
import '../data/flashcard_controller.dart';
import '../data/practice_repository.dart';

/// Screen for two-way Flashcard learning with 3D flip card animation and self-assessment.
class FlashcardScreen extends ConsumerStatefulWidget {
  const FlashcardScreen({super.key, this.direction = LearningDirection.jaToId});

  final LearningDirection direction;

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );

    // Initialize session with vocabulary pool
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = ref.read(practiceRepositoryProvider);
      final words = await repo.getPracticeVocabularies(limit: 10);
      ref
          .read(flashcardControllerProvider.notifier)
          .startSession(words: words, direction: widget.direction);
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _handleFlip() {
    if (_flipController.isAnimating) return;
    if (_flipController.isCompleted) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    ref.read(flashcardControllerProvider.notifier).flipCard();
  }

  Future<void> _handleRating(FlashcardRating rating) async {
    // Reset flip animation for next card
    if (_flipController.isCompleted) {
      _flipController.reset();
    }
    await ref.read(flashcardControllerProvider.notifier).rateCard(rating);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flashcardControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (state.words.isEmpty && !state.isCompleted) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.isCompleted) {
      return _FlashcardCompletedView(state: state);
    }

    final word = state.currentWord;
    if (word == null) {
      return const Scaffold(body: Center(child: Text('Tidak ada kosakata')));
    }

    final isJaToId = state.direction == LearningDirection.jaToId;

    return Scaffold(
      appBar: AppBar(
        title: Text(isJaToId ? 'Flashcard (JP → ID)' : 'Flashcard (ID → JP)'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                '${state.currentIndex + 1}/${state.totalWords}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: state.progress,
                  minHeight: 6,
                  backgroundColor: colorScheme.primaryContainer,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 3D Flip Card
              Expanded(
                child: GestureDetector(
                  onTap: _handleFlip,
                  child: AnimatedBuilder(
                    animation: _flipAnimation,
                    builder: (context, child) {
                      final angle = _flipAnimation.value * pi;
                      final isFront = angle <= (pi / 2);

                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // perspective
                          ..rotateY(angle),
                        alignment: Alignment.center,
                        child: isFront
                            ? _CardFront(word: word, isJaToId: isJaToId)
                            : Transform(
                                transform: Matrix4.identity()..rotateY(pi),
                                alignment: Alignment.center,
                                child: _CardBack(word: word),
                              ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Rating Buttons (Available when card is flipped)
              if (state.isFlipped) ...[
                Text(
                  'Bagaimana pemahaman Anda?',
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _RatingButton(
                        label: 'Again',
                        sublabel: 'Ulangi',
                        color: colorScheme.error,
                        onPressed: () => _handleRating(FlashcardRating.again),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _RatingButton(
                        label: 'Hard',
                        sublabel: 'Sulit',
                        color: const Color(0xFFC58B43), // Warning amber
                        onPressed: () => _handleRating(FlashcardRating.hard),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _RatingButton(
                        label: 'Good',
                        sublabel: 'Ingat',
                        color: const Color(0xFF71836B), // Success green
                        onPressed: () => _handleRating(FlashcardRating.good),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _RatingButton(
                        label: 'Easy',
                        sublabel: 'Mudah',
                        color: colorScheme.primary,
                        onPressed: () => _handleRating(FlashcardRating.easy),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _handleFlip,
                    icon: const Icon(Icons.flip_rounded, size: 18),
                    label: const Text('Buka Jawaban (Ketuk Kartu)'),
                  ),
                ),
              ],

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({required this.word, required this.isJaToId});

  final Vocabulary word;
  final bool isJaToId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Word type chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              word.wordType,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),

          const Spacer(),

          if (isJaToId) ...[
            FuriganaText(
              kanji: word.kanji,
              reading: word.hiragana,
              mainTextStyle: theme.textTheme.headlineLarge?.copyWith(
                fontSize: 38,
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
          ] else ...[
            Text(
              word.meaning,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                'Ketuk kartu untuk melihat arti',
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({required this.word});

  final Vocabulary word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.primary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FuriganaText(
            kanji: word.kanji,
            reading: word.hiragana,
            mainTextStyle: theme.textTheme.headlineLarge?.copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (word.romaji != null) ...[
            const SizedBox(height: 4),
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

          Text(
            word.meaning,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),

          if (word.exampleJp != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    word.exampleJp!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (word.exampleId != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      word.exampleId!,
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RatingButton extends StatelessWidget {
  const _RatingButton({
    required this.label,
    required this.sublabel,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final String sublabel;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sublabel,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlashcardCompletedView extends StatelessWidget {
  const _FlashcardCompletedView({required this.state});

  final FlashcardState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final remembered = state.goodCount + state.easyCount;
    final total = state.totalWords;
    final percent = total > 0 ? ((remembered / total) * 100).round() : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sesi Selesai'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/practice'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 64,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Latihan Selesai!',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$percent% kosakata berhasil diingat ($remembered dari $total kata)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Rating breakdown summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _SummaryChip(
                      label: 'Again',
                      count: state.againCount,
                      color: colorScheme.error,
                    ),
                    _SummaryChip(
                      label: 'Hard',
                      count: state.hardCount,
                      color: const Color(0xFFC58B43),
                    ),
                    _SummaryChip(
                      label: 'Good',
                      count: state.goodCount,
                      color: const Color(0xFF71836B),
                    ),
                    _SummaryChip(
                      label: 'Easy',
                      count: state.easyCount,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go('/practice'),
                  child: const Text('Kembali ke Menu Latihan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
