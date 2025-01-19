import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';

void showMusicDeleteConfirmationDialog(
  BuildContext context,
  WidgetRef ref,
  String musicId,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Music"),
        content: const Text("Are you sure you want to delete this music?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(musicProvider.notifier).deleteMusic(musicId);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Customize delete button color
            ),
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
