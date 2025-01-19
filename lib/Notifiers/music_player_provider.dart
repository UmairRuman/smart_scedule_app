import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_club_app/pages/timer_page/widgets/music_on_off_state_controller.dart';

/// Audio Player Provider
final audioPlayerProvider =
    NotifierProvider<AudioPlayerNotifier, MusicPlayerStates>(
        AudioPlayerNotifier.new);

class AudioPlayerNotifier extends Notifier<MusicPlayerStates> {
  bool isMusicPlaying = true;
  double currentVolume = 0.5;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  MusicPlayerStates build() {
    return MusicPlayerStopState();
  }

  /// Load a track by URL
  Future<void> setSource(String source, {bool isAsset = false}) async {
    try {
      if (isAsset) {
        await audioPlayer.setAsset(source);
      } else {
        await audioPlayer.setFilePath(source);
      }
      state = MusicPlayerReadyState(source);
    } catch (e) {
      // Handle error
    }
  }

  /// Play the current track
  void play() async {
    if (!isPlaying) {
      log("In Play method");
      await audioPlayer.play();
      ref.read(musiccOnOFStateProvider.notifier).updateButtonState(true);
      isMusicPlaying = true;
      state = MusicPlayerStartState(); // Trigger state change
    }
  }

  void pause() async {
    if (isPlaying) {
      log("In pause method");
      ref.read(musiccOnOFStateProvider.notifier).updateButtonState(false);
      await audioPlayer.pause();
      isMusicPlaying = false;
      state = MusicPlayerPauseState(); // Trigger state change
    }
  }

  /// Stop the playback
  void stop() async {
    await audioPlayer.stop();
    state = MusicPlayerStopState();
  }

  /// Set volume
  void setVolume(double volume) async {
    await audioPlayer.setVolume(volume);
    currentVolume = audioPlayer.volume;
    state = MusicPlayerVolumeChangeState(currentVolume: currentVolume);
  }

  /// Dispose the player when not needed
  void dispose() {
    audioPlayer.dispose();
  }

  /// Track playback position
  Stream<Duration> get positionStream => audioPlayer.positionStream;

  /// Track total duration
  Stream<Duration?> get durationStream => audioPlayer.durationStream;

  /// Check if audio is playing
  bool get isPlaying => audioPlayer.playing;

  /// Check if audio is paused
  bool get isPaused => !audioPlayer.playing && audioPlayer.currentIndex != null;
}

/// Music Player States
abstract class MusicPlayerStates {
  const MusicPlayerStates();
}

class MusicPlayerStopState extends MusicPlayerStates {}

class MusicPlayerStartState extends MusicPlayerStates {}

class MusicPlayerPauseState extends MusicPlayerStates {}

class MusicPlayerVolumeChangeState extends MusicPlayerStates {
  final double currentVolume;
  const MusicPlayerVolumeChangeState({required this.currentVolume});
}

class MusicPlayerReadyState extends MusicPlayerStates {
  final String url;
  const MusicPlayerReadyState(this.url);
}
