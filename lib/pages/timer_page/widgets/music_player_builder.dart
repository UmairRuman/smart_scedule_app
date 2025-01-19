import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';
import 'package:smart_club_app/pages/timer_page/widgets/music_stylish_slider.dart';

class CustomNeumorphicMusicPlayer extends ConsumerWidget {
  const CustomNeumorphicMusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final musicNotifier = ref.watch(musicProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 185, 224, 220),
              Color.fromARGB(255, 132, 198, 184),
              Color.fromARGB(255, 14, 103, 82)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                // Track Title
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.shade400,
                        const Color.fromARGB(255, 14, 114, 104),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.shade800.withOpacity(0.4),
                        offset: const Offset(5, 5),
                        blurRadius: 5,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      musicNotifier
                          .firstWhere((m) => m.isSelected,
                              orElse: () => musicNotifier[0])
                          .title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

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
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.teal.shade700,
                            inactiveTrackColor:
                                const Color.fromARGB(255, 54, 185, 172),
                            thumbColor: Colors.teal.shade900,
                            overlayColor: Colors.teal.shade600.withOpacity(0.2),
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 12,
                            ),
                            trackHeight: 6,
                          ),
                          child: Slider(
                            value: position.inSeconds.toDouble(),
                            max: total.inSeconds.toDouble(),
                            onChanged: (value) {
                              ref
                                  .read(audioPlayerProvider.notifier)
                                  .audioPlayer
                                  .seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDuration(position),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 4, 73, 66)),
                            ),
                            Text(
                              formatDuration(total),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 3, 44, 39)),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Play/Pause Button
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal.shade600,
                          Colors.teal.shade400,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade800.withOpacity(0.5),
                          offset: const Offset(4, 4),
                          blurRadius: 8,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        bool isPlaying =
                            ref.read(audioPlayerProvider.notifier).isPlaying;
                        if (isPlaying) {
                          ref.read(audioPlayerProvider.notifier).pause();
                          setState(() {});
                        } else {
                          ref.read(audioPlayerProvider.notifier).play();
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        ref.read(audioPlayerProvider.notifier).isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 40),

                // Volume Slider
                Column(
                  children: [
                    const Text(
                      'Volume',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 79, 72),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StylishLineSlider(
                      initialValue:
                          ref.read(audioPlayerProvider.notifier).currentVolume,
                      onChanged: (value) {
                        ref.read(audioPlayerProvider.notifier).setVolume(value);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Change Music
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Track:',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 79, 72),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Horizontal Scrollable Choice Chips
                    SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      child: Row(
                        children: musicNotifier.map((music) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0), // Spacing between chips
                            child: ChoiceChip(
                              label: Text(music.title),
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: music.isSelected
                                    ? Colors.white
                                    : Colors.teal.shade900,
                              ),
                              selected: music.isSelected,
                              selectedColor:
                                  const Color.fromARGB(255, 1, 90, 81),
                              backgroundColor: Colors.teal.shade100,
                              onSelected: (_) {
                                ref
                                    .read(musicProvider.notifier)
                                    .selectMusic(music.id);
                                ref
                                    .read(audioPlayerProvider.notifier)
                                    .setSource(music.url, isAsset: true);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
