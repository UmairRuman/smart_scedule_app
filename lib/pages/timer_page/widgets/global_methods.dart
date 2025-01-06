import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';
import 'package:smart_club_app/pages/timer_page/controller/edit_mode_provider.dart';

// void playMusic(String url, WidgetRef ref) async {
//   final player = ref.read(audioPlayerProvider);
//   await player.setUrl(url);
//   player.play();
// }

Future<void> toggleEditMode(BuildContext context, WidgetRef ref) async {
  final isEditMode = ref.watch(editModeProvider);
  if (!isEditMode) {
    // Require session/admin ID to enable edit mode
    final sessionKey = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Session/Admin Key'),
        content: SingleChildScrollView(
          child: TextField(
            decoration: const InputDecoration(hintText: 'Session/Admin Key'),
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
        ),
      ),
    );

    if (sessionKey == '123456') {
      ref.read(editModeProvider.notifier).state = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid session/admin key')),
      );
    }
  } else {
    ref.read(editModeProvider.notifier).state = false;
  }
}
