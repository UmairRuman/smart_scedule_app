import 'package:flutter_riverpod/flutter_riverpod.dart';

// MusicNotifier Provider
final musicProvider =
    NotifierProvider<MusicNotifier, List<Music>>(MusicNotifier.new);

// Music Model
class Music {
  final String id;
  final String title;
  final String url; // URL for the music file
  final bool isSelected;

  Music({
    required this.id,
    required this.title,
    required this.url,
    this.isSelected = false,
  });

  Music copyWith({bool? isSelected}) {
    return Music(
      id: id,
      title: title,
      url: url,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// MusicNotifier
class MusicNotifier extends Notifier<List<Music>> {
  List<Music> listofMusic = [];

  @override
  List<Music> build() {
    defaultMusicList();
    return listofMusic;
  }

  void defaultMusicList() {
    var music1 = Music(
      id: "1",
      title: "Ambient Relaxation",
      url: "assets/music/aRelaxation.mp3",
    );
    var music2 = Music(
      id: "2",
      title: "Energetic Beats",
      url: "assets/music/aRelaxation.mp3",
    );
    var music3 = Music(
      id: "3",
      title: "Relaxation Beats",
      url: "assets/music/aRelaxation.mp3",
    );
    var music4 = Music(
      id: "4",
      title: "Pop Music",
      url: "assets/music/aRelaxation.mp3",
    );

    listofMusic.addAll([music1, music2, music3, music4]);
  }

  void selectMusic(String id) {
    state = state.map((music) {
      if (music.id == id) {
        return music.copyWith(isSelected: true);
      }
      return music.copyWith(isSelected: false);
    }).toList();
  }

  void uploadMusic(String title, String url) {
    final newMusic = Music(
      id: DateTime.now().toString(), // Generate a unique ID
      title: title,
      url: url,
    );
    state = [...state, newMusic];
  }

  void deleteMusic(String id) {
    state = state.where((music) => music.id != id).toList();
  }
}
