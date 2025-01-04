import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/pages/controllers/session_notifier.dart';
import 'package:smart_club_app/pages/timer_page/controller/edit_mode_provider.dart';
import 'package:smart_club_app/pages/timer_page/widgets/global_methods.dart';
import 'package:smart_club_app/pages/timer_page/widgets/music_player_builder.dart';
import 'package:smart_club_app/pages/timer_page/widgets/timer_with_details.dart';

// Riverpod provider for edit mode state

class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({super.key});

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage> {
  late int endTime;

  @override
  void initState() {
    super.initState();
    final session = ref.read(sessionProvider);

    if (session != null) {
      endTime = DateTime.now()
          .add(Duration(minutes: session.duration + 2))
          .millisecondsSinceEpoch;
    } else {
      endTime = DateTime.now().millisecondsSinceEpoch;
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final isEditMode = ref.watch(editModeProvider);
    final selectedMusic = ref.watch(musicProvider).firstWhere(
          (music) => music.isSelected,
          orElse: () => Music(id: '', title: '', url: '', isSelected: false),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session In Progress'),
        actions: [
          Row(
            children: [
              const Text('Edit Mode'),
              Switch(
                value: isEditMode,
                onChanged: (_) => toggleEditMode(context, ref),
                activeColor: Colors.teal,
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: session != null
            ? isEditMode
                ? CustomNeumorphicMusicPlayer(
                    selectedMusic: selectedMusic,
                    ref: ref,
                  )
                : buildTimerWithDetails(
                    session, selectedMusic, endTime, context)
            : const Text('No active session'),
      ),
    );
  }
}
