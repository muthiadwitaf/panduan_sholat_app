import 'package:flutter/material.dart';
import '../models/doa_item.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/arabic_text_widget.dart';
import '../widgets/audio_button.dart';

class DoaDetailScreen extends StatelessWidget {
  final DoaItem doa;

  const DoaDetailScreen({
    super.key,
    required this.doa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doa.title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                  doa.category.toUpperCase(),
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.accentDark,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Audio Player
            if (doa.audioPath != null && doa.audioPath!.isNotEmpty)
              Column(
                children: [
                  MiniAudioPlayer(
                    audioPath: doa.audioPath,
                    title: 'Dengarkan Audio',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            
            // Arabic Text
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
              ),
              child: ArabicTextWidget(
                text: doa.arabicText,
                style: AppTextStyles.arabicLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Transliteration
            Text('LATIN', style: AppTextStyles.label),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
              ),
              child: Text(
                doa.transliteration,
                style: AppTextStyles.transliteration.copyWith(color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(height: 24),
            
            
            Text('ARTI', style: AppTextStyles.label),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Text(
                doa.translation,
                style: AppTextStyles.translation.copyWith(color: AppColors.textSecondary),
              ),
            ),
            
            
            if (doa.context != null && doa.context!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kapan Dibaca',
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.info,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doa.context!,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
