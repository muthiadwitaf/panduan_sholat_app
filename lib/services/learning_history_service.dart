import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/learning_history.dart';

/// Service untuk mengelola penyimpanan riwayat pembelajaran
class LearningHistoryService {
  static const String _historyKey = 'learning_history';
  
  /// Save a new learning history entry
  Future<void> saveHistory(LearningHistory history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final histories = await loadAllHistory();
      
      // Add new history
      histories.add(history);
      
      // Convert to JSON and save
      final jsonList = histories.map((h) => h.toJson()).toList();
      await prefs.setString(_historyKey, jsonEncode(jsonList));
    } catch (e) {
      // Error saving history
    }
  }
  
  /// Load all learning history
  Future<List<LearningHistory>> loadAllHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_historyKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => LearningHistory.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  /// Get history filtered by date range
  Future<List<LearningHistory>> getHistoryByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allHistory = await loadAllHistory();
    return allHistory.where((h) {
      return h.completedAt.isAfter(startDate) && 
             h.completedAt.isBefore(endDate);
    }).toList();
  }
  
  /// Get history for today
  Future<List<LearningHistory>> getTodayHistory() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return getHistoryByDateRange(startOfDay, endOfDay);
  }
  
  /// Get history for this week
  Future<List<LearningHistory>> getWeekHistory() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endDate = startDate.add(const Duration(days: 7));
    return getHistoryByDateRange(startDate, endDate);
  }
  
  /// Get total count of completed prayers
  Future<int> getTotalCompletedCount() async {
    final allHistory = await loadAllHistory();
    return allHistory.where((h) => h.isCompleted).length;
  }
  
  /// Get most studied prayer type
  Future<String?> getMostStudiedPrayer() async {
    final allHistory = await loadAllHistory();
    if (allHistory.isEmpty) return null;
    
    final Map<String, int> prayerCounts = {};
    for (var history in allHistory) {
      prayerCounts[history.prayerType] = 
          (prayerCounts[history.prayerType] ?? 0) + 1;
    }
    
    String? mostStudied;
    int maxCount = 0;
    prayerCounts.forEach((prayer, count) {
      if (count > maxCount) {
        maxCount = count;
        mostStudied = prayer;
      }
    });
    
    return mostStudied;
  }
  
  /// Get current learning streak (consecutive days)
  Future<int> getCurrentStreak() async {
    final allHistory = await loadAllHistory();
    if (allHistory.isEmpty) return 0;
    
    // Sort by date descending
    allHistory.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Check if there's activity today or yesterday
    final latestDate = DateTime(
      allHistory.first.completedAt.year,
      allHistory.first.completedAt.month,
      allHistory.first.completedAt.day,
    );
    
    if (latestDate.isBefore(today.subtract(const Duration(days: 1)))) {
      return 0; // Streak broken
    }
    
    int streak = 0;
    DateTime checkDate = today;
    
    for (var history in allHistory) {
      final historyDate = DateTime(
        history.completedAt.year,
        history.completedAt.month,
        history.completedAt.day,
      );
      
      if (historyDate == checkDate) {
        continue; // Same day, continue
      } else if (historyDate == checkDate.subtract(const Duration(days: 1))) {
        streak++;
        checkDate = historyDate;
      } else {
        break; // Gap found, stop counting
      }
    }
    
    return streak + 1; // +1 for today/latest day
  }
  
  /// Clear all history
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
  
  /// Get statistics summary
  Future<Map<String, dynamic>> getStatistics() async {
    final allHistory = await loadAllHistory();
    final totalCompleted = allHistory.where((h) => h.isCompleted).length;
    final mostStudied = await getMostStudiedPrayer();
    final streak = await getCurrentStreak();
    final todayCount = (await getTodayHistory()).length;
    final weekCount = (await getWeekHistory()).length;
    
    return {
      'totalCompleted': totalCompleted,
      'totalAttempts': allHistory.length,
      'mostStudiedPrayer': mostStudied,
      'currentStreak': streak,
      'todayCount': todayCount,
      'weekCount': weekCount,
    };
  }
}
