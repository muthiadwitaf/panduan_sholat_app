import 'package:flutter/material.dart';
import '../models/prayer_step.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'arabic_text_widget.dart';
import 'audio_button.dart';

class PrayerCard extends StatelessWidget {
  final PrayerStep step;

  const PrayerCard({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                children: [
                  if (step.rakaat != null && step.rakaat! > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: AppColors.premiumGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Rakaat ${step.rakaat}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      step.title,
                      style: AppTextStyles.headingMedium,
                    ),
                  ),
                ],
              ),
              
              // Audio Player
              if (step.audioPath != null && step.audioPath!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: MiniAudioPlayer(
                    audioPath: step.audioPath,
                    title: 'Dengarkan Bacaan',
                  ),
                ),
              
              const Divider(height: 32),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      step.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.background,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                            SizedBox(height: 8),
                            Text('Ilustrasi Gerakan', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              Text('BACAAN ARAB', style: AppTextStyles.label),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 80,
                  maxHeight: 200,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ArabicTextWidget(
                    text: step.arabicText,
                    style: AppTextStyles.arabicMedium.copyWith(
                      fontSize: 24,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              Text('LATIN', style: AppTextStyles.label),
              const SizedBox(height: 4),
              Text(
                step.latinText,
                style: AppTextStyles.transliteration.copyWith(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              Text('ARTI', style: AppTextStyles.label),
              const SizedBox(height: 4),
              Text(
                step.translation,
                style: AppTextStyles.translation.copyWith(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
