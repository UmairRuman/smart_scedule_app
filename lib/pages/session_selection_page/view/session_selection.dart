import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/core/dialogs/admin_authentication_dialog.dart';
import 'package:smart_club_app/pages/session_selection_page/controller/admin_mode_state_cotroller.dart';
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
    var isAdminMode = ref.watch(adminModeProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Club Session Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text(
                  'Admin Mode',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: isAdminMode,
                  onChanged: (value) async {
                    if (!value) {
                      ref
                          .read(adminModeProvider.notifier)
                          .toggleAdminMode(context);
                    } else {
                      bool? isAuthenticated =
                          await adminAuthenticationDialog(context, ref);
                      if (isAuthenticated == true) {
                        ref
                            .read(adminModeProvider.notifier)
                            .toggleAdminMode(context);
                      }
                    }
                  },
                  activeColor: Colors.teal,
                ),
              ],
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 10,
        shadowColor: Colors.tealAccent,
      ),
      body: SingleChildScrollView(
        // Makes the entire page scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side column
              Expanded(
                flex: 1,
                child: Column(
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
                    buildSectionTitle('Control IoT Devices'),
                    const SizedBox(height: 10),
                    IotControl(isAdminMode: isAdminMode),
                    const SizedBox(height: 20),
                    if (isAdminMode) BtnAddDevice(),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Right side column
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildSectionTitle('Select Music'),
                        if (isAdminMode) const Spacer(),
                        if (isAdminMode) BtnAddMusic(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Music Selection Builder
                    MusicSelectionBuilder(),
                    const SizedBox(height: 20),
                    const Center(
                      child: StartSessionButton(),
                    ),
                    isAdminMode ? SizedBox(height: 20) : SizedBox(),
                    isAdminMode ? BtnChangePretimer() : SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
