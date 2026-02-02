import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'doa_list_screen.dart';
import 'quiz_screen.dart';
import 'sholat_list_screen.dart';
import 'wudhu_guide_screen.dart';
import 'learning_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppColors.primary),
            onPressed: () => _showAboutDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.1),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Header section with Mosque illustration/icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.logoBackground,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.logoBackground.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mosque,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'E-Learning Interaktif',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.accent,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'E-Sholat Guide',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headingLarge.copyWith(
                          fontSize: 28,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.95,
                    children: [
                      _MenuCard(
                        icon: Icons.auto_stories,
                        title: 'Panduan\nSholat',
                        subtitle: 'Pahami langkahnya',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1D5F5F), Color(0xFF2A8A8A)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SholatListScreen(),
                            ),
                          );
                        },
                      ),
                      _MenuCard(
                        icon: Icons.menu_book,
                        title: 'Kumpulan\nDoa',
                        subtitle: 'Doa harian & dzikir',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4A84B), Color(0xFFE8C06A)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DoaListScreen(),
                            ),
                          );
                        },
                      ),
                      _MenuCard(
                        icon: Icons.psychology,
                        title: 'Kuis\nInteraktif',
                        subtitle: 'Uji pemahaman',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7B68A6), Color(0xFF9580B8)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuizScreen(),
                            ),
                          );
                        },
                      ),
                      _MenuCard(
                        icon: Icons.water_drop,
                        title: 'Tata Cara\nWudhu',
                        subtitle: 'Bersihkan diri',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A7BA7), Color(0xFF6A9BC4)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WudhuGuideScreen(),
                            ),
                          );
                        },
                      ),
                      _MenuCard(
                        icon: Icons.history_edu,
                        title: 'Riwayat\nBelajar',
                        subtitle: 'Lihat progress',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFB57B8C), Color(0xFFC9949E)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LearningHistoryScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.mosque, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Tentang Aplikasi'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'E-Sholat Guide',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Aplikasi pembelajaran interaktif yang dirancang untuk membantu umat Muslim mempelajari tata cara sholat, wudhu, dan doa harian dengan mudah dan menyenangkan.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Fitur Utama:',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• Panduan sholat lengkap dengan 19 langkah\n'
                '• Daftar sholat wajib dan sunnah dengan niat\n'
                '• Tata cara wudhu dengan 10 langkah\n'
                '• 78 doa harian dalam berbagai kategori\n'
                '• Kuis interaktif dengan 3 tingkat kesulitan\n'
                '• Riwayat belajar untuk tracking progress\n'
                '• Audio bacaan untuk membantu pelafalan',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'This application was developed as a final exam for the Sistem Informasi Dakwah course.',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'Tim Pengembang',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              _buildCreditRow('Team Leader', 'Dwi Agung Santoso'),
              const SizedBox(height: 8),
              _buildCreditRow('Developer', 'Muthi\'ah Dwita Fathinah'),
              const SizedBox(height: 8),
              _buildCreditRow('Analysts', 'Taufan Dwiyogo Setiawan\n& Triana Asih Wulandari'),
              const SizedBox(height: 8),
              _buildCreditRow('Reviewer', 'All Member'),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Versi 1.5.0',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textLight),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '©®2026',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditRow(String role, String name) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            role,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textLight,
            ),
          ),
        ),
        const Text(': '),
        Expanded(
          child: Text(
            name,
            style: AppTextStyles.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: AppTextStyles.headingSmall.copyWith(
                    height: 1.2,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
