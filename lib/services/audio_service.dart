import 'package:audioplayers/audioplayers.dart';

/// Service untuk mengelola pemutaran audio
/// Mendukung berbagai format: MP3, M4A, OGG
class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioPath;
  bool _isPlaying = false;

  /// Memutar atau pause audio
  /// Jika audio yang sama sedang diputar, akan di-pause
  /// Jika audio berbeda, akan stop audio sebelumnya dan putar yang baru
  Future<void> playAudio(String audioPath) async {
    try {
      if (_currentAudioPath == audioPath && _isPlaying) {
        // Pause jika audio yang sama sedang diputar
        await pauseAudio();
      } else {
        // Stop audio sebelumnya jika ada
        if (_isPlaying) {
          await stopAudio();
        }
        
        // Putar audio baru
        await _audioPlayer.play(AssetSource(audioPath));
        _currentAudioPath = audioPath;
        _isPlaying = true;
      }
    } catch (e) {
      // Error playing audio
      _isPlaying = false;
    }
  }

  /// Pause audio yang sedang diputar
  Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e) {
      // Error pausing audio
    }
  }

  /// Stop audio dan reset state
  Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentAudioPath = null;
    } catch (e) {
      // Error stopping audio
    }
  }

  /// Resume audio yang di-pause
  Future<void> resumeAudio() async {
    try {
      await _audioPlayer.resume();
      _isPlaying = true;
    } catch (e) {
      // Error resuming audio
    }
  }

  /// Cek apakah sedang memutar audio
  bool get isPlaying => _isPlaying;

  /// Dapatkan path audio yang sedang diputar
  String? get currentAudioPath => _currentAudioPath;

  /// Dispose audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}
