import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

/// Widget tombol audio yang reusable
/// Menampilkan tombol play/pause untuk memutar audio
class AudioButton extends StatelessWidget {
  final String? audioPath;
  final double size;
  final Color? color;
  final Color? activeColor;

  const AudioButton({
    super.key,
    required this.audioPath,
    this.size = 40,
    this.color,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    // Jika tidak ada audio path, jangan tampilkan tombol
    if (audioPath == null || audioPath!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        final isCurrentlyPlaying = audioProvider.isPlaying &&
            audioProvider.currentAudioPath == audioPath;

        return IconButton(
          icon: Icon(
            isCurrentlyPlaying ? Icons.pause_circle : Icons.play_circle,
            size: size,
            color: isCurrentlyPlaying
                ? (activeColor ?? Colors.green)
                : (color ?? Theme.of(context).primaryColor),
          ),
          onPressed: () {
            audioProvider.toggleAudio(audioPath!);
          },
          tooltip: isCurrentlyPlaying ? 'Pause Audio' : 'Putar Audio',
        );
      },
    );
  }
}

/// Widget mini audio player dengan kontrol lengkap
class MiniAudioPlayer extends StatelessWidget {
  final String? audioPath;
  final String title;

  const MiniAudioPlayer({
    super.key,
    required this.audioPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (audioPath == null || audioPath!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        final isCurrentlyPlaying = audioProvider.isPlaying &&
            audioProvider.currentAudioPath == audioPath;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.audiotrack,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  isCurrentlyPlaying ? Icons.pause : Icons.play_arrow,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  audioProvider.toggleAudio(audioPath!);
                },
              ),
              if (isCurrentlyPlaying)
                IconButton(
                  icon: Icon(
                    Icons.stop,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    audioProvider.stopAudio();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
