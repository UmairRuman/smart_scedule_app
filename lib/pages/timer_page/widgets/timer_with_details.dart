import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';
import 'package:smart_club_app/controllers/session_notifier.dart';
import 'package:smart_club_app/pages/alarm_page/alarm_page.dart';

class BuildTimerWithDetails extends ConsumerWidget {
  final SessionState session;
  final Music selectedMusic;
  final int endTime;
  const BuildTimerWithDetails(
      {super.key,
      required this.session,
      required this.selectedMusic,
      required this.endTime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Session Owner: ${session.name}',
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.tealAccent),
        ),
        const SizedBox(height: 30),
        CountdownTimer(
          endTime: endTime,
          widgetBuilder: (_, time) {
            if (time == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(sessionProvider.notifier).clearSession();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AlarmPage(),
                  ),
                );
              });
              ref.read(audioPlayerProvider.notifier).stop();
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
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            );
          },
        ),
        const SizedBox(height: 30),
        if (selectedMusic.id.isNotEmpty)
          Text(
            'Playing: ${selectedMusic.title}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}
