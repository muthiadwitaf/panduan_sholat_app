import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doa_item.dart';
import '../utils/data_loader.dart';

class DoaProvider with ChangeNotifier {
  List<DoaItem> _allDoas = [];
  List<DoaItem> _filteredDoas = [];
  Set<String> _favorites = {};
  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  List<DoaItem> get filteredDoas => _filteredDoas;
  List<DoaItem> get allDoas => _allDoas;
  Set<String> get favorites => _favorites;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  List<String> get categories {
    final cats = _allDoas.map((doa) => doa.category).toSet().toList();
    cats.insert(0, 'Semua');
    return cats;
  }

  Future<void> loadDoas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Map<String, dynamic> data = 
          await DataLoader.loadJsonMap('assets/data/doa_harian.json');
      
      final List<dynamic> doasJson = data['doaList'] as List;
      _allDoas = doasJson
          .map((json) => DoaItem.fromJson(json as Map<String, dynamic>))
          .toList();
      
      await _loadFavorites();
      
      _allDoas = _allDoas.map((doa) {
        return doa.copyWith(isFavorite: _favorites.contains(doa.id));
      }).toList();
      
      _filteredDoas = List.from(_allDoas);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Gagal memuat data doa: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesList = prefs.getStringList('favorite_doas') ?? [];
      _favorites = favoritesList.toSet();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorite_doas', _favorites.toList());
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }

  Future<void> toggleFavorite(String doaId) async {
    if (_favorites.contains(doaId)) {
      _favorites.remove(doaId);
    } else {
      _favorites.add(doaId);
    }
    
    _allDoas = _allDoas.map((doa) {
      if (doa.id == doaId) {
        return doa.copyWith(isFavorite: _favorites.contains(doaId));
      }
      return doa;
    }).toList();
    
    await _saveFavorites();
    _applyFilters();
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredDoas = _allDoas.where((doa) {
      final categoryMatch = _selectedCategory == 'Semua' || 
          doa.category == _selectedCategory;
      
      final searchMatch = _searchQuery.isEmpty ||
          doa.title.toLowerCase().contains(_searchQuery) ||
          doa.transliteration.toLowerCase().contains(_searchQuery);
      
      return categoryMatch && searchMatch;
    }).toList();
  }

  DoaItem? getDoaById(String id) {
    try {
      return _allDoas.firstWhere((doa) => doa.id == id);
    } catch (e) {
      return null;
    }
  }
}
