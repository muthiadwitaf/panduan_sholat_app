import 'package:flutter/foundation.dart';
import '../models/learning_history.dart';
import '../services/learning_history_service.dart';

class LearningHistoryProvider with ChangeNotifier {
  final LearningHistoryService _service = LearningHistoryService();
  
  List<LearningHistory> _allHistory = [];
  List<LearningHistory> _filteredHistory = [];
  Map<String, dynamic> _statistics = {};
  bool _isLoading = false;
  String? _error;
  
  
  String? _selectedPrayerType;
  DateTime? _startDate;
  DateTime? _endDate;
  
    
  List<LearningHistory> get allHistory => _allHistory;
  List<LearningHistory> get filteredHistory => _filteredHistory;
  Map<String, dynamic> get statistics => _statistics;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedPrayerType => _selectedPrayerType;
  
    
  Future<void> loadHistory() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _allHistory = await _service.loadAllHistory();
        
      _allHistory.sort((a, b) => b.completedAt.compareTo(a.completedAt));
      _filteredHistory = List.from(_allHistory);
      
      await loadStatistics();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Gagal memuat riwayat: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
  

  Future<void> addHistory({
    required String prayerType,
    required String prayerName,
    required int stepsCompleted,
    required int totalSteps,
    int? durationSeconds,
  }) async {
    try {
      final history = LearningHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        prayerType: prayerType,
        prayerName: prayerName,
        completedAt: DateTime.now(),
        stepsCompleted: stepsCompleted,
        totalSteps: totalSteps,
        durationSeconds: durationSeconds,
      );
      
      await _service.saveHistory(history);
      await loadHistory();
    } catch (e) {
      _error = 'Gagal menyimpan riwayat: $e';
      notifyListeners();
    }
  }
  
  Future<void> loadStatistics() async {
    try {
      _statistics = await _service.getStatistics();
      notifyListeners();
    } catch (e) {
      // Statistik gagal dimuat, abaikan dan gunakan nilai default
      debugPrint('Failed to load statistics: $e');
    }
  }
  
  void filterByPrayerType(String? prayerType) {
    _selectedPrayerType = prayerType;
    _applyFilters();
  }
  
  void filterByDateRange(DateTime? startDate, DateTime? endDate) {
    _startDate = startDate;
    _endDate = endDate;
    _applyFilters();
  }
  
  void clearFilters() {
    _selectedPrayerType = null;
    _startDate = null;
    _endDate = null;
    _filteredHistory = List.from(_allHistory);
    notifyListeners();
  }
  
  void _applyFilters() {
    _filteredHistory = _allHistory.where((history) {
      if (_selectedPrayerType != null && 
          history.prayerType != _selectedPrayerType) {
        return false;
      }
      
      if (_startDate != null && history.completedAt.isBefore(_startDate!)) {
        return false;
      }
      if (_endDate != null && history.completedAt.isAfter(_endDate!)) {
        return false;
      }
      
      return true;
    }).toList();
    
    notifyListeners();
  }
  
  Map<String, List<LearningHistory>> getGroupedByDate() {
    final Map<String, List<LearningHistory>> grouped = {};
    
    for (var history in _filteredHistory) {
      final dateKey = '${history.completedAt.year}-${history.completedAt.month.toString().padLeft(2, '0')}-${history.completedAt.day.toString().padLeft(2, '0')}';
      
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(history);
    }
    
    return grouped;
  }
  
  Future<void> clearAllHistory() async {
    try {
      await _service.clearHistory();
      await loadHistory();
    } catch (e) {
      _error = 'Gagal menghapus riwayat: $e';
      notifyListeners();
    }
  }
}
