import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';

class MusicSelectionBuilder extends ConsumerWidget {
  const MusicSelectionBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        shrinkWrap:
            true, // Allows it to be contained inside another scrollable widget
        physics:
            const NeverScrollableScrollPhysics(), // Prevents inner scrolling
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          final music = musicList[index];
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0), // Adds spacing
                child: ListTile(
                  leading: const Icon(
                    Icons.music_note,
                    color: Colors.tealAccent,
                    size: 40, // Larger icon size
                  ),
                  title: Text(
                    music.title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 22), // Larger font size
                  ),
                  trailing: Icon(
                    size: 40,
                    music.isSelected
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: Colors.tealAccent,
                  ),
                  onTap: () {
                    ref
                        .read(audioPlayerProvider.notifier)
                        .setSource(music.url, isAsset: music.isAsset);
                    ref
                        .read(musicProvider.notifier)
                        .selectMusic(musicList[index].id);
                  },
                ),
              ),
              if (index < musicList.length - 1)
                const Divider(color: Colors.white54),
            ],
          );
        },
      ),
    );
  }
}
