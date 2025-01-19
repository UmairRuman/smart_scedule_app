import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/controllers/session_notifier.dart';
import 'package:smart_club_app/core/dialogs/admin_authentication_dialog.dart';
import 'package:smart_club_app/pages/alarm_page/alarm_page.dart';
import 'package:smart_club_app/pages/session_selection_page/controller/admin_mode_state_cotroller.dart';
import 'package:smart_club_app/pages/timer_page/controller/edit_mode_provider.dart';
import 'package:smart_club_app/pages/timer_page/widgets/global_methods.dart';
import 'package:smart_club_app/pages/timer_page/widgets/music_player_builder.dart';
import 'package:smart_club_app/pages/timer_page/widgets/timer_progress_painter.dart';
import 'package:smart_club_app/util/screen_metaData.dart';

class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({super.key});

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late int totalTimeInSeconds;

  @override
  void initState() {
    super.initState();

    final session = ref.read(sessionProvider);
    if (session != null) {
      totalTimeInSeconds = session.duration * 60; // Convert duration to seconds
    } else {
      totalTimeInSeconds = 0;
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalTimeInSeconds),
    );

    _progressAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start countdown timer
    _controller.forward();

    // Listener for animation status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ref.read(sessionProvider.notifier).clearSession();
        // Navigate to Alarm Page
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AlarmPage(),
            ));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getTimeString() {
    int minutes = (totalTimeInSeconds -
            (_controller.value * totalTimeInSeconds).toInt()) ~/
        60;
    int seconds = (totalTimeInSeconds -
            (_controller.value * totalTimeInSeconds).toInt()) %
        60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final session = ref.watch(sessionProvider);
    final isEditMode = ref.watch(editModeProvider);
    final selectedMusic = ref.watch(musicProvider).firstWhere(
          (music) => music.isSelected,
          orElse: () => Music(
              id: '', title: '', url: '', isAsset: false, isSelected: false),
        );

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            bool result = await adminAuthenticationDialog(context, ref);
            if (result) {
              ref.read(sessionProvider.notifier).clearSession();
              ref.read(adminModeProvider.notifier).clearAdminKeyController();
              Navigator.pop(context);
            } else {
              ref.read(adminModeProvider.notifier).clearAdminKeyController();
            }
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
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
          'Session In Progress',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text(
                  'Edit Mode',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: isEditMode,
                  onChanged: (_) => toggleEditMode(context, ref),
                  activeColor: Colors.tealAccent,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004D40), Color(0xFF26A69A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: session != null
            ? isEditMode
                ? const CustomNeumorphicMusicPlayer() // Replace with edit mode UI
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          // Circular Timer Progress
                          AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: TimerProgressPainter(
                                    progress: _progressAnimation.value),
                                child: SizedBox(
                                  width: getScreenHeight(context) * 0.5,
                                  height: getScreenHeight(context) * 0.5,
                                  child: Center(
                                    child: Text(
                                      getTimeString(),
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 30),

                          // Session Details
                          Text(
                            'Session: ${session.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Music: ${selectedMusic.title}',
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white70),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
            : const Center(
                child: Text(
                  'No active session',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
      ),
    );
  }
}
