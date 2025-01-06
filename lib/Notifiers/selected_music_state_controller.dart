// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smart_club_app/Notifiers/music_player_notifier.dart';

// class SelectedMusicStateController extends Notifier<List<bool>> {
//   List<bool> mapOfSelectedMusic = [];
//   @override
//   List<bool> build() {
//     return mapOfSelectedMusic;
//   }

//   void intiallizedSelectedMusic(List<Music> list) {
//     mapOfSelectedMusic = List.generate(list.length, (index) => false);
//   }

//   void selectMusic(int index) {
//     mapOfSelectedMusic[index] = !mapOfSelectedMusic[index];
//     state = amapOfSelectedMusic;
//   }
// }
