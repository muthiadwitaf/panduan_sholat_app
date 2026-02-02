import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/quiz_option_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _showingExplanation = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      final provider = Provider.of<QuizProvider>(context, listen: false);
      await provider.loadQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Interaktif'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (quizProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(quizProvider.error!, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => quizProvider.loadQuestions(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          
          if (quizProvider.currentQuestions.isEmpty) {
            return _buildStartScreen(quizProvider);
          }

          
          if (quizProvider.lastResult != null) {
            return _buildResultScreen(quizProvider);
          }

         
          return _buildQuizScreen(quizProvider);
        },
      ),
    );
  }

  Widget _buildStartScreen(QuizProvider provider) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppColors.premiumGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.quiz,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Kuis Interaktif',
              style: AppTextStyles.headingLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Uji pemahamanmu tentang tata cara sholat dengan menjawab pertanyaan yang tersedia.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Text(
              'Pilih Tingkat Kesulitan',
              style: AppTextStyles.headingSmall,
            ),
            const SizedBox(height: 16),
            _DifficultyCard(
              title: 'Mudah',
              subtitle: 'Pertanyaan dasar tentang sholat',
              icon: Icons.sentiment_satisfied,
              color: AppColors.success,
              questionCount: provider.difficultyCount['mudah'] ?? 0,
              onTap: () {
                provider.startQuiz(questionCount: 10, difficulty: 'mudah');
                setState(() => _showingExplanation = false);
              },
            ),
            const SizedBox(height: 12),
            _DifficultyCard(
              title: 'Sedang',
              subtitle: 'Pertanyaan lebih detail',
              icon: Icons.sentiment_neutral,
              color: AppColors.warning,
              questionCount: provider.difficultyCount['sedang'] ?? 0,
              onTap: () {
                provider.startQuiz(questionCount: 10, difficulty: 'sedang');
                setState(() => _showingExplanation = false);
              },
            ),
            const SizedBox(height: 12),
            _DifficultyCard(
              title: 'Susah',
              subtitle: 'Pertanyaan mendalam & aplikatif',
              icon: Icons.sentiment_very_dissatisfied,
              color: AppColors.error,
              questionCount: provider.difficultyCount['susah'] ?? 0,
              onTap: () {
                provider.startQuiz(questionCount: 10, difficulty: 'susah');
                setState(() => _showingExplanation = false);
              },
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                provider.startQuiz(questionCount: 10);
                setState(() => _showingExplanation = false);
              },
              icon: const Icon(Icons.shuffle),
              label: const Text('Semua Tingkat (Acak)'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizScreen(QuizProvider provider) {
    final question = provider.currentQuestion!;
    final userAnswer = provider.getUserAnswer(provider.currentQuestionIndex);
    final isAnswered = userAnswer != null;

    return Column(
      children: [
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pertanyaan ${provider.currentQuestionIndex + 1} dari ${provider.totalQuestions}',
                    style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.8)),
                  ),
                  Text(
                    '${((provider.currentQuestionIndex + 1) / provider.totalQuestions * 100).toStringAsFixed(0)}%',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  value: (provider.currentQuestionIndex + 1) / provider.totalQuestions,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                ),
              ),
            ],
          ),
        ),
        
        
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      question.category.toUpperCase(),
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.accentDark,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                
                Text(
                  question.question,
                  style: AppTextStyles.headingMedium,
                ),
                const SizedBox(height: 24),
                
                
                ...List.generate(question.options.length, (index) {
                  final isUserAnswer = userAnswer == index;
                  bool? isCorrect;
                  
                  if (isAnswered && _showingExplanation) {
                    if (index == question.correctAnswerIndex) {
                      isCorrect = true;
                    } else if (isUserAnswer) {
                      isCorrect = false;
                    }
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: QuizOptionCard(
                      optionText: question.options[index],
                      optionIndex: index,
                      isSelected: isUserAnswer,
                      isCorrect: isCorrect,
                      onTap: () {
                        if (!isAnswered) {
                          provider.submitAnswer(index);
                          setState(() => _showingExplanation = true);
                        }
                      },
                    ),
                  );
                }),
                
                
                if (isAnswered && _showingExplanation) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: userAnswer == question.correctAnswerIndex
                          ? AppColors.success.withValues(alpha: 0.05)
                          : AppColors.warning.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: userAnswer == question.correctAnswerIndex
                            ? AppColors.success.withValues(alpha: 0.2)
                            : AppColors.warning.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              userAnswer == question.correctAnswerIndex
                                  ? Icons.check_circle
                                  : Icons.info,
                              color: userAnswer == question.correctAnswerIndex
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              userAnswer == question.correctAnswerIndex
                                  ? 'Benar!'
                                  : 'Pembahasan',
                              style: AppTextStyles.headingSmall.copyWith(
                                color: userAnswer == question.correctAnswerIndex
                                    ? AppColors.success
                                    : AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question.explanation,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              if (provider.hasPrevious)
                IconButton.filled(
                  onPressed: () {
                    provider.previousQuestion();
                    setState(() => _showingExplanation = false);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              if (provider.hasPrevious) const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: isAnswered
                      ? () {
                          if (provider.hasNext) {
                            provider.nextQuestion();
                            setState(() => _showingExplanation = false);
                          } else if (provider.isQuizComplete) {
                            provider.calculateResult();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                  ),
                  child: Text(
                    provider.hasNext ? 'Pertanyaan Berikutnya' : 'Lihat Hasil Kuis',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultScreen(QuizProvider provider) {
    final result = provider.lastResult!;
    final percentage = result.scorePercentage;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: percentage >= 75
                  ? const LinearGradient(
                      colors: [AppColors.success, Color(0xFF66BB6A)],
                    )
                  : percentage >= 60
                      ? const LinearGradient(
                          colors: [AppColors.warning, Color(0xFFFFB74D)],
                        )
                      : const LinearGradient(
                          colors: [AppColors.error, Color(0xFFEF5350)],
                        ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              percentage >= 75
                  ? Icons.emoji_events
                  : percentage >= 60
                      ? Icons.thumb_up
                      : Icons.replay,
              size: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            result.grade,
            style: AppTextStyles.headingLarge,
          ),
          const SizedBox(height: 32),
          
          
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: percentage >= 75
                          ? AppColors.success
                          : percentage >= 60
                              ? AppColors.warning
                              : AppColors.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        icon: Icons.check_circle,
                        label: 'Benar',
                        value: '${result.correctAnswers}',
                        color: AppColors.success,
                      ),
                      _StatItem(
                        icon: Icons.cancel,
                        label: 'Salah',
                        value: '${result.incorrectAnswers}',
                        color: AppColors.error,
                      ),
                      _StatItem(
                        icon: Icons.list,
                        label: 'Total',
                        value: '${result.totalQuestions}',
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.info.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: AppColors.info),
                    const SizedBox(width: 8),
                    Text(
                      'Rekomendasi',
                      style: AppTextStyles.headingSmall.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  percentage >= 75
                      ? 'Luar biasa! Pengetahuan Anda tentang tata cara sholat sudah sangat baik. Terus pertahankan dan amalkan!'
                      : percentage >= 60
                          ? 'Bagus! Anda sudah memahami dasar-dasar sholat dengan baik. Tingkatkan lagi dengan mempelajari panduan sholat.'
                          : 'Tetap semangat! Pelajari kembali panduan sholat untuk meningkatkan pemahaman Anda.',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    provider.reset();
                    setState(() => _showingExplanation = false);
                  },
                  child: const Text('Ulangi Kuis'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Kembali'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}

class _DifficultyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int questionCount;
  final VoidCallback onTap;

  const _DifficultyCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.questionCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: questionCount > 0 ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: questionCount > 0 ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: questionCount > 0 ? color.withValues(alpha: 0.3) : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: questionCount > 0 ? [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headingSmall.copyWith(
                      color: questionCount > 0 ? AppColors.textPrimary : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: questionCount > 0 ? AppColors.textSecondary : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$questionCount soal',
                style: AppTextStyles.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
