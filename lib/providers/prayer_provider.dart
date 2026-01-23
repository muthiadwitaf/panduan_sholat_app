import 'package:flutter/foundation.dart';
import '../models/prayer_step.dart';
import '../models/sholat_item.dart';
import '../utils/data_loader.dart';

class PrayerProvider with ChangeNotifier {
  List<PrayerStep> _prayerSteps = [];
  List<SholatItem> _sholatList = [];
  Map<String, List<String>> _patterns = {};
  int _currentStepIndex = 0;
  bool _isLoading = false;
  String? _error;

  List<PrayerStep> get prayerSteps => _prayerSteps;
  List<SholatItem> get sholatList => _sholatList;
  int get currentStepIndex => _currentStepIndex;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  PrayerStep? get currentStep => 
      _prayerSteps.isNotEmpty ? _prayerSteps[_currentStepIndex] : null;
  
  bool get hasNext => _currentStepIndex < _prayerSteps.length - 1;
  bool get hasPrevious => _currentStepIndex > 0;

  Future<void> loadPrayerSteps({String? sholatId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_sholatList.isEmpty) await loadSholatList();
      
      final sholat = _sholatList.firstWhere(
        (s) => s.id == sholatId,
        orElse: () => _sholatList.isNotEmpty ? _sholatList[0] : throw Exception('Sholat not found'),
      );

      final Map<String, dynamic> stepsData = await DataLoader.loadJsonMap('assets/data/prayer_steps.json');
      final Map<String, dynamic> patternsData = await DataLoader.loadJsonMap('assets/data/rakaat_patterns.json');
      
      final List<dynamic> stepsJson = stepsData['prayerSteps'] as List;
      final List<PrayerStep> allBaseSteps = stepsJson
          .map((json) => PrayerStep.fromJson(json as Map<String, dynamic>))
          .toList();

      final Map<String, dynamic> patternsJson = patternsData['patterns'] as Map<String, dynamic>;
      _patterns = patternsJson.map((key, value) => MapEntry(key, List<String>.from(value as List)));
      
      _prayerSteps = _generateFullSequence(sholat, allBaseSteps);
      
      _currentStepIndex = 0;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Gagal memuat panduan sholat: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  List<PrayerStep> _generateFullSequence(SholatItem sholat, List<PrayerStep> baseSteps) {
    PrayerStep getStep(String id) => baseSteps.firstWhere(
      (s) => s.stepId == id,
      orElse: () => throw Exception('Step $id not found'),
    );

    List<String> stepIds = List.from(_patterns[sholat.pattern] ?? _patterns['dua_rakaat']!);
    List<PrayerStep> sequence = [];

    int maxRakaat = 0;
    if (sholat.pattern == 'satu_rakaat' || sholat.pattern == 'jenazah') {
      maxRakaat = (sholat.pattern == 'jenazah') ? 0 : 1;
    } else if (sholat.pattern == 'dua_rakaat') {
      maxRakaat = 2;
    } else if (sholat.pattern == 'tiga_rakaat' || sholat.pattern == 'witir_tiga_rakaat') {
      maxRakaat = 3;
    } else if (sholat.pattern == 'empat_rakaat') {
      maxRakaat = 4;
    }

    int currentRakaat = (maxRakaat > 0) ? 1 : 0;
    int fatihahCountInRakaat = 0;

    for (int i = 0; i < stepIds.length; i++) {
      String id = stepIds[i];
      
      if (id == 'fatihah') {
        fatihahCountInRakaat++;
        if (fatihahCountInRakaat > 1 && !sholat.id.contains('gerhana')) {
          currentRakaat++;
          fatihahCountInRakaat = 1;
        }
      }

      var step = getStep(id).copyWith(rakaat: currentRakaat == 0 ? null : currentRakaat);

      if (id == 'niat' && sholat.niat != null) {
        step = step.copyWith(
          arabicText: sholat.niat!.arabicText,
          latinText: sholat.niat!.latinText,
          translation: sholat.niat!.translation,
        );
      }

      if (sholat.id.contains('idul') && id == 'takbir') {
        sequence.add(step);
        int extraCount = (currentRakaat == 1) ? 7 : 5;
        for (int j = 1; j <= extraCount; j++) {
          sequence.add(getStep('takbir_extra').copyWith(
            rakaat: currentRakaat,
            title: 'Takbir Tambahan $j'
          ));
        }
        continue;
      }

      if (sholat.id.contains('gerhana') && id == 'itidal' && fatihahCountInRakaat == 1) {
        sequence.add(step);
        sequence.add(getStep('fatihah').copyWith(rakaat: currentRakaat, title: 'Al-Fatihah (Kedua)'));
        sequence.add(getStep('surat').copyWith(rakaat: currentRakaat, title: 'Surat Pendek (Kedua)'));
        sequence.add(getStep('ruku').copyWith(rakaat: currentRakaat, title: 'Ruku (Kedua)'));
        sequence.add(getStep('itidal').copyWith(rakaat: currentRakaat, title: 'I\'tidal (Kedua)'));
        fatihahCountInRakaat = 2;
        continue;
      }

      if (sholat.id == 'sholat_tasbih') {
        sequence.add(step);
        if (id == 'surat') {
          sequence.add(getStep('tasbih').copyWith(rakaat: currentRakaat, title: 'Bacaan Tasbih (15x)'));
        } else if (['ruku', 'itidal', 'sujud', 'duduk_sujud'].contains(id)) {
          sequence.add(getStep('tasbih').copyWith(rakaat: currentRakaat, title: 'Bacaan Tasbih (10x)'));
        }
        if (id == 'sujud' && i > 0 && stepIds[i-1] == 'duduk_sujud') {
           sequence.add(getStep('tasbih').copyWith(rakaat: currentRakaat, title: 'Bacaan Tasbih (10x)'));
        }
        continue;
      }

      if (sholat.id == 'sholat_subuh' && currentRakaat == 2 && id == 'itidal') {
        sequence.add(step);
        sequence.add(getStep('qunut').copyWith(rakaat: 2));
        continue;
      }

      if (sholat.pattern.contains('witir') || sholat.id.contains('witir')) {
        if (id == 'itidal' && currentRakaat == maxRakaat && maxRakaat > 0) {
          sequence.add(step);
          sequence.add(getStep('qunut').copyWith(rakaat: currentRakaat, title: 'Doa Qunut (Witir)'));
          continue;
        }
      }

      sequence.add(step);
    }

    return sequence;
  }

  Future<void> loadSholatList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Map<String, dynamic> data = await DataLoader.loadJsonMap('assets/data/sholat_list.json');
      final List<dynamic> listJson = data['sholatList'] as List;
      _sholatList = listJson.map((json) => SholatItem.fromJson(json as Map<String, dynamic>)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Gagal memuat daftar sholat: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextStep() {
    if (hasNext) {
      _currentStepIndex++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (hasPrevious) {
      _currentStepIndex--;
      notifyListeners();
    }
  }

  void reset() {
    _currentStepIndex = 0;
    notifyListeners();
  }
}
