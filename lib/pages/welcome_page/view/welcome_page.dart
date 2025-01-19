import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/controllers/all_device_state_controller.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/pages/session_selection_page/view/session_selection.dart';
import 'package:smart_club_app/protocol/Firestore_mqtt_Bridge.dart';
import 'package:smart_club_app/protocol/mqt_service.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends ConsumerState<WelcomePage>
    with TickerProviderStateMixin {
  final MqttService _mqttService = MqttService();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    startListeningToFirestore(
        context, globalUserId, _mqttService); // Listen to Firestore changes
    // Connect to MQTT and subscribe to topics
    _mqttService.connect().then((_) async {
      // Subscribe to user-specific topics using wildcards
      final userId =
          globalUserId; // Replace with dynamic user ID for multi-user apps
      final topic =
          'user/$userId/device/+/status'; // Wildcard for all user devices
      // await Future.delayed(const Duration(seconds: 3));
      _mqttService.subscribeToTopic(topic);
    });

    //Getting all devices
    getAllDevices();

    // Initialize Fade Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the fade animation
    _controller.forward();

    // Initialize Blinking Animation Controller
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _blinkAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_blinkController);
  }

  void getAllDevices() async {
    // await ref.read(fansPageStateProvider.notifier).getAllFans("Fan");
    // await ref.read(bulbsPageStateProvider.notifier).getAllBulbs("Bulb");
    await ref.read(allDeviceStateProvider.notifier).getAlldevices();
  }

  @override
  void dispose() {
    _controller.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SessionSelectionPage();
              },
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Animated Background Ripples
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      width: _controller.value * 400,
                      height: _controller.value * 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.tealAccent.withOpacity(0.2),
                            Colors.black.withOpacity(0.0),
                          ],
                          stops: [0.5, 1],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Fade-In Animated Text
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Welcome to the Club!',
                        style: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Blinking Text
                      FadeTransition(
                        opacity: _blinkAnimation,
                        child: const Text(
                          'Tap anywhere to proceed',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 35.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
