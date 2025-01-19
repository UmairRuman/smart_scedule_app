import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';
import 'package:smart_club_app/controllers/session_notifier.dart';
import 'package:smart_club_app/core/dialogs/admin_authentication_dialog.dart';
import 'package:smart_club_app/core/services/service_locater.dart';
import 'package:smart_club_app/core/services/shared_prefrence_Service.dart';
import 'package:smart_club_app/pages/preTimer_page/widgets/timer_painter.dart';
import 'package:smart_club_app/pages/session_selection_page/controller/admin_mode_state_cotroller.dart';
import 'package:smart_club_app/pages/timer_page/view/timer_page.dart';

class PretimerPage extends ConsumerStatefulWidget {
  const PretimerPage({super.key});

  @override
  ConsumerState<PretimerPage> createState() => PretimerPageState();
}

class PretimerPageState extends ConsumerState<PretimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  int duration = int.parse(
          serviceLocator.get<SharedPrefrenceService>().getCurrentPretimer()) *
      1; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for the timer
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    // Animation for circular progress
    _progressAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the countdown
    _controller.forward();

    // Navigate to TimerPage when countdown ends
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // When the session get completed
        startAllConfigurationsForMusic();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TimerPage()),
        );
      }
    });
  }

  startAllConfigurationsForMusic() async {
    Music selectedMusic = ref.read(musicProvider).firstWhere(
          (music) => music.isSelected,
        );
    ref.read(sessionProvider.notifier).updateSession();
    bool isAsset = selectedMusic.isAsset;
    await ref
        .read(audioPlayerProvider.notifier)
        .setSource(selectedMusic.url, isAsset: isAsset);
    ref.read(audioPlayerProvider.notifier).play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getTimeString() {
    int minutes = (duration - (_controller.value * duration).toInt()) ~/ 60;
    int seconds = (duration - (_controller.value * duration).toInt()) % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pretimer has been started',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
      ),
      body: Center(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF004D40), Color(0xFF26A69A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Gradient background
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Heading Text
                      Text(
                        'Get Ready!',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),

                      // Circular Timer
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: TimerPainter(
                              progress: _progressAnimation.value,
                            ),
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Center(
                                child: Text(
                                  getTimeString(), // Time in minutes:seconds format
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
                      const SizedBox(height: 40),

                      // Subheading Text
                      const Text(
                        'Your session will start soon.',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
