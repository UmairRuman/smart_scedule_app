import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';

Widget buildTimerWithDetails(
    session, Music selectedMusic, int endTime, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Session Owner: ${session.name}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      CountdownTimer(
        endTime: endTime,
        widgetBuilder: (_, time) {
          if (time == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            return const Text(
              'Session Completed',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          return Text(
            '${time.hours ?? 0}:${time.min ?? 0}:${time.sec ?? 0}',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          );
        },
      ),
      const SizedBox(height: 20),
      if (selectedMusic.id.isNotEmpty)
        Text(
          'Playing: ${selectedMusic.title}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
    ],
  );
}
