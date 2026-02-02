import 'package:flutter/foundation.dart';
import '../services/audio_service.dart';

class AudioProvider with ChangeNotifier {
  final AudioService _audioService = AudioService();

  bool get isPlaying => _audioService.isPlaying;

  String? get currentAudioPath => _audioService.currentAudioPath;

  Future<void> toggleAudio(String audioPath) async {
    await _audioService.playAudio(audioPath);
    notifyListeners();
  }

  Future<void> stopAudio() async {
    await _audioService.stopAudio();
    notifyListeners();
  }

  Future<void> pauseAudio() async {
    await _audioService.pauseAudio();
    notifyListeners();
  }
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
