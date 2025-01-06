import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// MusicNotifier Provider
final musicProvider =
    NotifierProvider<MusicNotifier, List<Music>>(MusicNotifier.new);

// Music Model
class Music {
  final String id;
  final String title;
  final String url; // URL for the music file
  final bool isSelected;
  final bool isAsset;

  Music({
    required this.isAsset,
    required this.id,
    required this.title,
    required this.url,
    this.isSelected = false,
  });

  Music copyWith({bool? isSelected}) {
    return Music(
      isAsset: isAsset,
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
    loadMusic();
    return listofMusic;
  }

  void loadMusic() async {
    var music1 = Music(
      isAsset: true,
      id: "1",
      title: "Ambient Relaxation",
      url: "assets/music/aRelaxation.mp3",
    );
    var music2 = Music(
      isAsset: true,
      id: "2",
      title: "Energetic Beats",
      url: "assets/music/energetics.mp3",
    );
    var music3 = Music(
      isAsset: true,
      id: "3",
      title: "Relaxation Beats",
      url: "assets/music/relaxtionBeat.mp3",
    );
    var music4 = Music(
      isAsset: true,
      id: "4",
      title: "Pop Music",
      url: "assets/music/popBeat.mp3",
    );

    listofMusic.addAll([music1, music2, music3, music4]);

// Load from local directory
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path).listSync();
    for (var file in files) {
      if (file is File && file.path.endsWith(".mp3")) {
        listofMusic.add(
          Music(
            id: file.path,
            title: file.uri.pathSegments.last,
            url: file.path,
            isAsset: false,
          ),
        );
      }
    }
    state = [...listofMusic];
  }

  void selectMusic(String id) {
    state = state.map((music) {
      if (music.id == id) {
        return music.copyWith(isSelected: true);
      }
      return music.copyWith(isSelected: false);
    }).toList();
  }

  void uploadMusic(String path, String title) {
    final newMusic = Music(
      id: path,
      title: title,
      url: path,
      isAsset: false,
    );
    listofMusic.add(newMusic);
    state = [...listofMusic];
  }

  void deleteMusic(String id) {
    listofMusic.removeWhere((music) => music.id == id);
    if (!id.startsWith("assets")) {
      File(id).deleteSync();
    }
    state = [...listofMusic];
  }
}
