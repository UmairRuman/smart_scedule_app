import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/core/dialogs/music_deletion_confimation_dialog.dart';
import 'package:smart_club_app/pages/add_music/widgets/music_name_dialog.dart';

class MusicAdditionPage extends ConsumerWidget {
  const MusicAdditionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Music",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final musicList = ref.watch(musicProvider);
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.tealAccent,
                          thickness: 1.0,
                        ),
                        itemCount: musicList.length,
                        itemBuilder: (context, index) {
                          final music = musicList[index];
                          return ListTile(
                            leading: Icon(
                              Icons.music_note,
                              color: Colors.tealAccent,
                              size: 30,
                            ),
                            title: Text(
                              music.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                showMusicDeleteConfirmationDialog(
                                  context,
                                  ref,
                                  music.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Center(
              child: ElevatedButton.icon(
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
                    final musicName = await showMusicNameInputDialog(context);
                    if (musicName != null && musicName.trim().isNotEmpty) {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final savedFile =
                          await file.copy('${directory.path}/$fileName');

                      // Update the music list
                      ref
                          .read(musicProvider.notifier)
                          .uploadMusic(savedFile.path, musicName);
                    }
                  }
                },
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  "Add Music",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
