import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';

Widget buildMusicSelection(WidgetRef ref) {
  final musicList = ref.watch(musicProvider);

  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: musicList.length,
      itemBuilder: (context, index) {
        final music = musicList[index];
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.music_note, color: Colors.tealAccent),
              title: Text(
                music.title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: Icon(
                music.isSelected
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                color: Colors.tealAccent,
              ),
              onTap: () =>
                  ref.read(musicProvider.notifier).selectMusic(music.id),
            ),
            if (index < musicList.length - 1)
              const Divider(color: Colors.white54),
          ],
        );
      },
    ),
  );
}
