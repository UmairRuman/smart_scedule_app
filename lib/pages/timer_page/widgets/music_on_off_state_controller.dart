import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';

final musiccOnOFStateProvider =
    NotifierProvider<MusicOffOnController, bool>(MusicOffOnController.new);

class MusicOffOnController extends Notifier<bool> {
  @override
  bool build() {
    return ref.read(audioPlayerProvider.notifier).isPlaying;
  }

  void intializeButtonState(bool value) {
    state = value;
  }

  void updateButtonState(bool value) {
    state = value;
  }
}
