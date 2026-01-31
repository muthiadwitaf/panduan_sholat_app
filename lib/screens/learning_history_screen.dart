import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/learning_history_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class LearningHistoryScreen extends StatefulWidget {
  const LearningHistoryScreen({super.key});

  @override
  State<LearningHistoryScreen> createState() => _LearningHistoryScreenState();
}

class _LearningHistoryScreenState extends State<LearningHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<LearningHistoryProvider>(context, listen: false).loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Belajar'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<LearningHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(provider.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadHistory(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (provider.allHistory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada riwayat belajar',
                    style: AppTextStyles.headingMedium.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mulai belajar sholat untuk melihat riwayat',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Statistics Cards
                _buildStatisticsSection(provider),
                
                const SizedBox(height: 16),
                
                // Timeline
                _buildTimelineSection(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatisticsSection(LearningHistoryProvider provider) {
    final stats = provider.statistics;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.premiumGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistik Belajar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.check_circle,
                  label: 'Total Selesai',
                  value: '${stats['totalCompleted'] ?? 0}',
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.local_fire_department,
                  label: 'Streak',
                  value: '${stats['currentStreak'] ?? 0} hari',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.today,
                  label: 'Hari Ini',
                  value: '${stats['todayCount'] ?? 0}',
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.date_range,
                  label: 'Minggu Ini',
                  value: '${stats['weekCount'] ?? 0}',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          if (stats['mostStudiedPrayer'] != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Paling Sering Dipelajari',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          stats['mostStudiedPrayer'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection(LearningHistoryProvider provider) {
    final groupedHistory = provider.getGroupedByDate();
    final dates = groupedHistory.keys.toList()..sort((a, b) => b.compareTo(a));
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Riwayat Aktivitas',
                style: AppTextStyles.headingMedium,
              ),
              if (provider.allHistory.isNotEmpty)
                TextButton(
                  onPressed: () {
                    // Show filter options
                    _showFilterDialog(provider);
                  },
                  child: Row(
                    children: [
                      Icon(
                        provider.selectedPrayerType != null 
                            ? Icons.filter_alt 
                            : Icons.filter_alt_outlined,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      const Text('Filter'),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          ...dates.map((date) {
            final histories = groupedHistory[date]!;
            return _buildDateGroup(date, histories);
          }),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDateGroup(String date, List histories) {
    final DateTime dateTime = DateTime.parse(date);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    String dateLabel;
    if (dateOnly == today) {
      dateLabel = 'Hari Ini';
    } else if (dateOnly == yesterday) {
      dateLabel = 'Kemarin';
    } else {
      dateLabel = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            dateLabel,
            style: AppTextStyles.label.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...histories.map((history) => _buildHistoryItem(history)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHistoryItem(history) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: history.isCompleted 
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              history.isCompleted ? Icons.check_circle : Icons.timelapse,
              color: history.isCompleted ? AppColors.success : AppColors.warning,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.prayerName,
                  style: AppTextStyles.headingSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  '${history.completedAt.hour.toString().padLeft(2, '0')}:${history.completedAt.minute.toString().padLeft(2, '0')} • ${history.stepsCompleted}/${history.totalSteps} langkah',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: history.isCompleted 
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              history.isCompleted ? 'Selesai' : '${history.completionPercentage.toStringAsFixed(0)}%',
              style: TextStyle(
                color: history.isCompleted ? AppColors.success : AppColors.warning,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(LearningHistoryProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Riwayat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Semua Sholat'),
              leading: Radio<String?>(
                value: null,
                groupValue: provider.selectedPrayerType,
                onChanged: (value) {
                  provider.filterByPrayerType(value);
                  Navigator.pop(context);
                },
              ),
            ),
            ...['Subuh', 'Dzuhur', 'Ashar', 'Maghrib', 'Isya'].map((prayer) {
              return ListTile(
                title: Text(prayer),
                leading: Radio<String?>(
                  value: prayer,
                  groupValue: provider.selectedPrayerType,
                  onChanged: (value) {
                    provider.filterByPrayerType(value);
                    Navigator.pop(context);
                  },
                ),
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.clearFilters();
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
