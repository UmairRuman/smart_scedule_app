import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';

class MusicAdditionPage extends ConsumerWidget {
  const MusicAdditionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Music"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final musicList = ref.watch(musicProvider);
                return ListView.builder(
                  itemCount: musicList.length,
                  itemBuilder: (context, index) {
                    final music = musicList[index];
                    return ListTile(
                      leading: const Icon(Icons.music_note),
                      title: Text(music.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmationDialog(
                            context,
                            ref,
                            music.id,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'mp3',
                  'wav',
                  'aac'
                ], // Allowed audio formats
              );
              if (result != null) {
                final file = File(result.files.single.path!);
                final fileName = file.uri.pathSegments.last;

                // Show a dialog to input music name
                final musicName = await _showMusicNameInputDialog(context);
                if (musicName != null && musicName.trim().isNotEmpty) {
                  final directory = await getApplicationDocumentsDirectory();
                  final savedFile =
                      await file.copy('${directory.path}/$fileName');

                  // Update the music list
                  ref
                      .read(musicProvider.notifier)
                      .uploadMusic(savedFile.path, musicName);
                }
              }
            },
            child: const Text("Add Music"),
          ),
        ],
      ),
    );
  }

  Future<String?> _showMusicNameInputDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Music Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Music Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  Navigator.of(context).pop(controller.text.trim());
                } else {
                  // Show error if the name is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Music name cannot be empty!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
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
}
