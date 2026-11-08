import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/furigana_text.dart';
import '../data/practice_repository.dart';
import '../data/survival_controller.dart';

/// Endless Survival Quiz mode with 3 lives.
class SurvivalScreen extends ConsumerStatefulWidget {
  const SurvivalScreen({super.key});

  @override
  ConsumerState<SurvivalScreen> createState() => _SurvivalScreenState();
}

class _SurvivalScreenState extends ConsumerState<SurvivalScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = ref.read(practiceRepositoryProvider);
      final words = await repo.getPracticeVocabularies(limit: 50);
      ref.read(survivalControllerProvider.notifier).startSurvival(pool: words);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(survivalControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (state.pool.isEmpty && !state.isGameOver) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.isGameOver) {
      return _SurvivalGameOverView(state: state);
    }

    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final word = question.targetWord;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mode Bertahan (Survival)'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/practice'),
        ),
        actions: [
          // Hearts Row (3 Lives)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(3, (index) {
                final isAlive = index < state.lives;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    isAlive
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isAlive
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    size: 24,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Score Banner
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: colorScheme.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Skor: ${state.score}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Nyawa tersisa: ${state.lives}/3',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Question Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  children: [
                    Text(
                      'Pilihlah jawaban yang tepat:',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
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
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Multiple Choice Options
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final option = question.options[index];
                    return _OptionTile(
                      optionText: option,
                      isAnswered: state.isAnswered,
                      isSelected: option == state.selectedAnswer,
                      isCorrectOption: option == question.correctAnswer,
                      onTap: () {
                        ref
                            .read(survivalControllerProvider.notifier)
                            .answer(option);
                      },
                    );
                  },
                ),
              ),

              // Explanation / Next Button
              if (state.isAnswered) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: state.selectedAnswer == question.correctAnswer
                        ? const Color(0xFF71836B).withValues(alpha: 0.12)
                        : colorScheme.error.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: state.selectedAnswer == question.correctAnswer
                          ? const Color(0xFF71836B)
                          : colorScheme.error,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        state.selectedAnswer == question.correctAnswer
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: state.selectedAnswer == question.correctAnswer
                            ? const Color(0xFF71836B)
                            : colorScheme.error,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.selectedAnswer == question.correctAnswer
                                  ? 'Tepat sekali! (+1 Poin)'
                                  : 'Salah! Kehilangan 1 nyawa (Jawaban: ${question.correctAnswer})',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color:
                                    state.selectedAnswer ==
                                        question.correctAnswer
                                    ? const Color(0xFF71836B)
                                    : colorScheme.error,
                              ),
                            ),
                            if (word.exampleJp != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                '${word.exampleJp} — ${word.exampleId ?? ''}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    ref
                        .read(survivalControllerProvider.notifier)
                        .nextQuestion();
                  },
                  child: const Text('Lanjut ke Kata Berikutnya'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.optionText,
    required this.isAnswered,
    required this.isSelected,
    required this.isCorrectOption,
    required this.onTap,
  });

  final String optionText;
  final bool isAnswered;
  final bool isSelected;
  final bool isCorrectOption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor = colorScheme.surface;
    Color borderColor = theme.dividerColor;
    Color textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    if (isAnswered) {
      if (isCorrectOption) {
        backgroundColor = const Color(0xFF71836B).withValues(alpha: 0.15);
        borderColor = const Color(0xFF71836B);
        textColor = const Color(0xFF71836B);
      } else if (isSelected) {
        backgroundColor = colorScheme.error.withValues(alpha: 0.15);
        borderColor = colorScheme.error;
        textColor = colorScheme.error;
      }
    }

    return InkWell(
      onTap: isAnswered ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: isSelected || (isAnswered && isCorrectOption) ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected || (isAnswered && isCorrectOption)
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
            if (isAnswered && isCorrectOption)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF71836B),
                size: 20,
              ),
            if (isAnswered && isSelected && !isCorrectOption)
              Icon(Icons.cancel_rounded, color: colorScheme.error, size: 20),
          ],
        ),
      ),
    );
  }
}

class _SurvivalGameOverView extends ConsumerWidget {
  const _SurvivalGameOverView({required this.state});

  final SurvivalState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permainan Berakhir'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/practice'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.error.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.heart_broken_rounded,
                  size: 64,
                  color: colorScheme.error,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Nyawa Habis!',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Anda berhasil menebak ${state.score} kosakata berturut-turut.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Score Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${state.score}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Skor Sesi Ini',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Container(height: 36, width: 1, color: theme.dividerColor),
                    Column(
                      children: [
                        Text(
                          '${state.bestScore}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFC58B43),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Skor Terbaik',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Review of missed words
              if (state.mistakes.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kosakata yang Keliru (${state.mistakes.length}):',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.mistakes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final m = state.mistakes[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FuriganaText(
                            kanji: m.word.kanji,
                            reading: m.word.hiragana,
                            mainTextStyle: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Jawaban: ${m.userAnswer}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: colorScheme.error,
                                ),
                              ),
                              Text(
                                'Koreksi: ${m.correctAnswer}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF71836B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    ref
                        .read(survivalControllerProvider.notifier)
                        .startSurvival(pool: state.pool);
                  },
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('Main Lagi (3 Nyawa Penuh)'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/practice'),
                  child: const Text('Kembali ke Pusat Latihan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
