import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/furigana_text.dart';
import '../data/quiz_controller.dart';

/// Screen displayed upon completing a quiz session, highlighting accuracy and mistake review.
class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key, required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final accuracyInt = state.accuracy.round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/practice'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Score Banner
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
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: accuracyInt >= 70
                            ? const Color(0xFF71836B).withValues(alpha: 0.15)
                            : colorScheme.error.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        accuracyInt >= 70
                            ? Icons.emoji_events_outlined
                            : Icons.replay_rounded,
                        size: 48,
                        color: accuracyInt >= 70
                            ? const Color(0xFF71836B)
                            : colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$accuracyInt%',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: accuracyInt >= 70
                            ? const Color(0xFF71836B)
                            : colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      accuracyInt >= 70
                          ? 'Bagus sekali! Pemahaman kosakata sudah mantap.'
                          : 'Perlu pengulangan. Tinjau kembali kosakata di bawah ini.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Correct vs Wrong chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StatChip(
                          icon: Icons.check_circle_rounded,
                          label: '${state.correctCount} Benar',
                          color: const Color(0xFF71836B),
                        ),
                        const SizedBox(width: 16),
                        _StatChip(
                          icon: Icons.cancel_rounded,
                          label: '${state.wrongCount} Salah',
                          color: colorScheme.error,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Mistake Tracking Section (PRD FR-04)
              if (state.mistakes.isNotEmpty) ...[
                Text(
                  'Daftar Evaluasi Kesalahan (${state.mistakes.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.mistakes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final mistake = state.mistakes[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colorScheme.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          FuriganaText(
                            kanji: mistake.word.kanji,
                            reading: mistake.word.hiragana,
                            mainTextStyle: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.close,
                                      size: 14,
                                      color: colorScheme.error,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        'Jawaban Anda: ${mistake.userAnswer}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colorScheme.error,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Color(0xFF71836B),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        'Koreksi: ${mistake.correctAnswer}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF71836B),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Action Buttons
              FilledButton(
                onPressed: () => context.go('/practice'),
                child: const Text('Selesai & Kembali ke Menu'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => context.go('/'),
                child: const Text('Ke Beranda'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
