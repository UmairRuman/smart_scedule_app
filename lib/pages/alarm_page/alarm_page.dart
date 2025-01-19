import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_club_app/pages/welcome_page/view/welcome_page.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  AlarmPageState createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAlarm();
  }

  Future<void> _playAlarm() async {
    // Replace with your alarm sound asset file
    _audioPlayer.setAsset('assets/music/dangerAlarm.mp3');
    await _audioPlayer.play();
    _audioPlayer.setLoopMode(LoopMode.all); // Loop the alarm
  }

  Future<void> _stopAlarm() async {
    await _audioPlayer.stop(); // Stop the alarm
  }

  @override
  void dispose() {
    _stopAlarm(); // Ensure the alarm stops when the page is disposed
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.alarm,
                size: 100,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              Text(
                'Session Completed!',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'The alarm will stop when you press "End Session".',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _stopAlarm(); // Stop the alarm

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const WelcomePage()),
                      (route) => false); // Close the page
                },
                child: const Text('End Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
