import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/furigana_text.dart';
import '../data/practice_repository.dart';
import '../data/quiz_controller.dart';
import 'quiz_result_screen.dart';

/// Interactive Quiz screen displaying questions one by one with immediate answer validation.
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key, this.questionCount = 5});

  final int questionCount;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = ref.read(practiceRepositoryProvider);
      final words = await repo.getPracticeVocabularies(limit: 20);
      ref
          .read(quizControllerProvider.notifier)
          .startQuiz(pool: words, questionCount: widget.questionCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (quizState.questions.isEmpty && !quizState.isCompleted) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (quizState.isCompleted) {
      return QuizResultScreen(state: quizState);
    }

    final question = quizState.currentQuestion;
    if (question == null) {
      return const Scaffold(body: Center(child: Text('Tidak ada soal')));
    }

    final word = question.targetWord;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Kosakata (${quizState.currentIndex + 1}/${quizState.totalQuestions})',
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/practice'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: quizState.progress,
                  minHeight: 6,
                  backgroundColor: colorScheme.primaryContainer,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 24),

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
                      question.direction == LearningDirection.jaToId
                          ? 'Pilihlah arti yang benar:'
                          : 'Pilihlah kosakata bahasa Jepang yang tepat:',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    if (question.direction == LearningDirection.jaToId) ...[
                      FuriganaText(
                        kanji: word.kanji,
                        reading: word.hiragana,
                        mainTextStyle: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: 32,
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
                    ] else ...[
                      Text(
                        word.meaning,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Options
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final option = question.options[index];
                    return _OptionButton(
                      optionText: option,
                      isAnswered: question.isAnswered,
                      isSelected: option == question.selectedAnswer,
                      isCorrectOption: option == question.correctAnswer,
                      onTap: () {
                        ref
                            .read(quizControllerProvider.notifier)
                            .answer(option);
                      },
                    );
                  },
                ),
              ),

              // Explanation / Next Button
              if (question.isAnswered) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: question.isCorrect
                        ? const Color(0xFF71836B).withValues(alpha: 0.12)
                        : colorScheme.error.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: question.isCorrect
                          ? const Color(0xFF71836B)
                          : colorScheme.error,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        question.isCorrect
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: question.isCorrect
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
                              question.isCorrect
                                  ? 'Benar! Jawaban tepat.'
                                  : 'Kurang tepat. Jawaban yang benar: ${question.correctAnswer}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: question.isCorrect
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
                                maxLines: 2,
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
                    ref.read(quizControllerProvider.notifier).nextQuestion();
                  },
                  child: Text(
                    quizState.currentIndex + 1 >= quizState.totalQuestions
                        ? 'Lihat Hasil Akhir'
                        : 'Lanjut ke Soal Berikutnya',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
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
