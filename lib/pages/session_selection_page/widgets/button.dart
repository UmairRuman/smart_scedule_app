import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/pages/controllers/session_notifier.dart';
import 'package:smart_club_app/pages/timer_page/view/timer_page.dart';

class StartSessionButton extends ConsumerWidget {
  const StartSessionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameKey = ref.read(sessionProvider.notifier).globalNameKey;
    final sessionKey = ref.read(sessionProvider.notifier).globalSessionKey;
    final durationKey = ref.read(sessionProvider.notifier).globalDurationKey;
    return ElevatedButton(
      onPressed: () {
        // if (nameKey.currentState!.validate() &&
        //     sessionKey.currentState!.validate() &&
        //     durationKey.currentState!.validate()) {
        //   // All fields are valid

        // } else {
        //   // Show validation errors
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Please fix the errors')),
        //   );
        // }
        ref.read(sessionProvider.notifier).updateSession();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TimerPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.tealAccent,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Start Session',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
