import 'package:flutter/foundation.dart';
import '../services/audio_service.dart';

/// Provider untuk state management audio
/// Mengelola state pemutaran audio di seluruh aplikasi
class AudioProvider with ChangeNotifier {
  final AudioService _audioService = AudioService();

  /// Cek apakah sedang memutar audio
  bool get isPlaying => _audioService.isPlaying;

  /// Dapatkan path audio yang sedang diputar
  String? get currentAudioPath => _audioService.currentAudioPath;

  /// Toggle play/pause audio
  /// Jika audio yang sama sedang diputar, akan di-pause
  /// Jika audio berbeda, akan stop audio sebelumnya dan putar yang baru
  Future<void> toggleAudio(String audioPath) async {
    await _audioService.playAudio(audioPath);
    notifyListeners();
  }

  /// Stop audio yang sedang diputar
  Future<void> stopAudio() async {
    await _audioService.stopAudio();
    notifyListeners();
  }

  /// Pause audio
  Future<void> pauseAudio() async {
    await _audioService.pauseAudio();
    notifyListeners();
  }

  /// Resume audio
  Future<void> resumeAudio() async {
    await _audioService.resumeAudio();
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}
