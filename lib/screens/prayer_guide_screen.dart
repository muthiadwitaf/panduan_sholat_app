import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_provider.dart';
import '../providers/learning_history_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/prayer_card.dart';

class PrayerGuideScreen extends StatefulWidget {
  final String? sholatId;
  const PrayerGuideScreen({super.key, this.sholatId});

  @override
  State<PrayerGuideScreen> createState() => _PrayerGuideScreenState();
}

class _PrayerGuideScreenState extends State<PrayerGuideScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<PrayerProvider>(context, listen: false).loadPrayerSteps(sholatId: widget.sholatId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Sholat'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<PrayerProvider>(
        builder: (context, prayerProvider, child) {
          if (prayerProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (prayerProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    prayerProvider.error!,
                    style: AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => prayerProvider.loadPrayerSteps(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (prayerProvider.prayerSteps.isEmpty) {
            return const Center(
              child: Text('Tidak ada data panduan sholat'),
            );
          }

          final currentStep = prayerProvider.currentStep!;

          return Column(
            children: [
              
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress Belajar',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          '${((prayerProvider.currentStepIndex + 1) / prayerProvider.prayerSteps.length * 100).toStringAsFixed(0)}%',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: (prayerProvider.currentStepIndex + 1) / 
                            prayerProvider.prayerSteps.length,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                      ),
                    ),
                  ],
                ),
              ),
              
              
              Expanded(
                child: PrayerCard(step: currentStep),
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
                    if (prayerProvider.hasPrevious)
                      IconButton.filled(
                        onPressed: () => prayerProvider.previousStep(),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    if (prayerProvider.hasPrevious) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (prayerProvider.hasNext) {
                            prayerProvider.nextStep();
                          } else {
                            _showCompletionDialog(context, prayerProvider);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              prayerProvider.hasNext ? 'Langkah Berikutnya' : 'Selesai Belajar',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (prayerProvider.hasNext) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCompletionDialog(BuildContext context, PrayerProvider provider) {
    // Save to learning history
    final historyProvider = Provider.of<LearningHistoryProvider>(context, listen: false);
    historyProvider.addHistory(
      prayerType: provider.currentPrayerName ?? 'Sholat',
      prayerName: provider.currentPrayerName ?? 'Sholat',
      stepsCompleted: provider.prayerSteps.length,
      totalSteps: provider.prayerSteps.length,
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Selamat!'),
        content: const Text(
          'Anda telah menyelesaikan panduan sholat. Semoga bermanfaat!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              provider.reset();
            },
            child: const Text('Ulang dari Awal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Kembali ke Beranda'),
          ),
        ],
      ),
    );
  }
}
