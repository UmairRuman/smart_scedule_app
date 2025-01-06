import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';

class CustomNeumorphicMusicPlayer extends ConsumerWidget {
  const CustomNeumorphicMusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final musicNotifier = ref.watch(musicProvider);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Track Title
            Text(
              musicNotifier
                  .firstWhere((m) => m.isSelected,
                      orElse: () => musicNotifier[0])
                  .title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Progress Slider
            StreamBuilder<Duration>(
              stream: ref.read(audioPlayerProvider.notifier).positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = ref
                        .read(audioPlayerProvider.notifier)
                        .audioPlayer
                        .duration ??
                    Duration.zero;
                return Column(
                  children: [
                    Slider(
                      value: position.inSeconds.toDouble(),
                      max: total.inSeconds.toDouble(),
                      onChanged: (value) {
                        ref
                            .read(audioPlayerProvider.notifier)
                            .audioPlayer
                            .seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDuration(position)),
                        Text(formatDuration(total)),
                      ],
                    ),
                  ],
                );
              },
            ),

            // Play/Pause Button
            GestureDetector(
              onTap: () {
                ref.read(audioPlayerProvider.notifier).isPlaying
                    ? ref.read(audioPlayerProvider.notifier).pause()
                    : ref.read(audioPlayerProvider.notifier).play();
              },
              child: Icon(
                ref.read(audioPlayerProvider.notifier).isMusicPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
                size: 80,
                color: Colors.teal,
              ),
            ),

            const SizedBox(height: 20),

            // Volume Slider
            Column(
              children: [
                const Text('Volume'),
                Slider(
                  value: ref
                      .read(audioPlayerProvider.notifier)
                      .currentVolume, // Example volume
                  onChanged: (value) {
                    ref.read(audioPlayerProvider.notifier).setVolume(value);
                  },
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                ),
              ],
            ),

            // Change Music
            const SizedBox(height: 20),
            Text('Select Track:'),
            Wrap(
              spacing: 10,
              children: musicNotifier.map((music) {
                return ChoiceChip(
                  label: Text(music.title),
                  selected: music.isSelected,
                  onSelected: (_) {
                    ref.read(musicProvider.notifier).selectMusic(music.id);
                    ref
                        .read(audioPlayerProvider.notifier)
                        .setSource(music.url, isAsset: true);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Format duration to mm:ss
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
