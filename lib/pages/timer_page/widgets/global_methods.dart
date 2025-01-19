import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/controllers/session_notifier.dart';
import 'package:smart_club_app/pages/timer_page/controller/edit_mode_provider.dart';

// void playMusic(String url, WidgetRef ref) async {
//   final player = ref.read(audioPlayerProvider);
//   await player.setUrl(url);
//   player.play();
// }

Future<void> toggleEditMode(BuildContext context, WidgetRef ref) async {
  final isEditMode = ref.watch(editModeProvider);

  if (!isEditMode) {
    // Show a dialog to require session/admin ID to enable edit mode
    final sessionKey = await showDialog<String>(
      context: context,
      builder: (context) {
        final keyController = TextEditingController();

        return SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Enter Session/Admin Key',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please enter the session/admin key to enable edit mode.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: keyController,
                  decoration: InputDecoration(
                    hintText: 'Enter Session/Admin Key',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.tealAccent, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context, keyController.text); // Return entered key
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context, ""); // Return false on cancel
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16, color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // Validate the session/admin key
    if (sessionKey != null &&
        sessionKey == ref.read(sessionProvider.notifier).keyTEC.text) {
      ref.read(editModeProvider.notifier).state = true; // Enable edit mode
    } else if (sessionKey != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid session/admin key')),
      );
    }
  } else {
    ref.read(editModeProvider.notifier).state = false; // Disable edit mode
  }
}
