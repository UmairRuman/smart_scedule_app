import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/button.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/header.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/iot_control.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/music_selection_widget.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/section_title.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/text_fields.dart';

class SessionSelectionPage extends ConsumerWidget {
  const SessionSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Club Session Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 10,
        shadowColor: Colors.tealAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side column
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  buildHeader('Welcome to the Club'),
                  const SizedBox(height: 20),
                  buildSectionTitle('Start a New Session'),
                  const SizedBox(height: 10),
                  const KeyTextField(),
                  const SizedBox(height: 10),
                  const NameTextField(),
                  const SizedBox(height: 10),
                  const DurationTextField(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Right side column
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  buildSectionTitle('Select Music'),
                  buildMusicSelection(ref),
                  const SizedBox(height: 20),
                  buildSectionTitle('Control IoT Devices'),
                  buildIotControls(),
                  const SizedBox(height: 20),
                  const Center(
                    child: StartSessionButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
