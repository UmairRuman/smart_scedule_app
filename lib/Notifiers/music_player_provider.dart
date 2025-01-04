import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

/// A provider for the audio player
final audioPlayerProvider = Provider<AudioPlayerNotifier>((ref) {
  return AudioPlayerNotifier();
});

/// A notifier to manage audio playback
class AudioPlayerNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Play a track from a given URL
  Future<void> setUrl(String url) async {
    try {
      await _audioPlayer.setUrl(url);
    } catch (e) {
      print('Error loading audio URL: $e');
    }
  }

  /// Play the audio
  void play() {
    _audioPlayer.play();
  }

  /// Pause the audio
  void pause() {
    _audioPlayer.pause();
  }

  /// Stop the audio
  void stop() {
    _audioPlayer.stop();
  }

  /// Dispose of the audio player when not needed
  void dispose() {
    _audioPlayer.dispose();
  }

  /// Check if audio is currently playing
  bool get isPlaying => _audioPlayer.playing;

  /// Check if audio is paused
  bool get isPaused =>
      !_audioPlayer.playing && _audioPlayer.currentIndex != null;

  /// Get the current playback position
  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  /// Get the total duration of the current track
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
}
