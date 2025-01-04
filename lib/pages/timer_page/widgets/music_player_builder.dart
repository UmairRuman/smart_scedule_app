import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';

class CustomNeumorphicMusicPlayer extends StatelessWidget {
  final Music selectedMusic;
  final WidgetRef ref;

  const CustomNeumorphicMusicPlayer({
    Key? key,
    required this.selectedMusic,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(audioPlayerProvider);

    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        padding: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Now Playing Title
              Text(
                'Now Playing: ${selectedMusic.title}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Play/Pause Button
              GestureDetector(
                onTap: () {
                  player.isPlaying ? player.pause() : player.play();
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    player.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Speed Slider
              Column(
                children: [
                  const Text(
                    'Volume',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Slider(
                    value: 1.0,
                    onChanged: (value) {
                      // Adjust speed logic
                    },
                    min: 0.5,
                    max: 2.0,
                    divisions: 6,
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Navigation Buttons (Backward/Forward)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Backward Button
                  GestureDetector(
                    onTap: () {
                      // Logic for backward
                    },
                    child: buildCircleButton(Icons.skip_previous, Colors.teal),
                  ),
                  // Forward Button
                  GestureDetector(
                    onTap: () {
                      // Logic for forward
                    },
                    child: buildCircleButton(Icons.skip_next, Colors.teal),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Progress Bar
              Column(
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Slider(
                    value: 0.3, // Example value for progress
                    onChanged: (value) {
                      // Adjust progress logic
                    },
                    min: 0.0,
                    max: 1.0,
                    activeColor: Colors.teal,
                    inactiveColor: Colors.grey[400],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0:00', style: TextStyle(color: Colors.black54)),
                      Text('3:30', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Circle button for Backward/Forward
  Widget buildCircleButton(IconData icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon, size: 30, color: color),
    );
  }
}
