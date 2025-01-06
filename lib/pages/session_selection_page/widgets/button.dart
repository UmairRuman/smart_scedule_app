import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';
import 'package:smart_club_app/controllers/session_notifier.dart';
import 'package:smart_club_app/pages/add_devices_page/view/add_device_page.dart';
import 'package:smart_club_app/pages/add_music/view/music_addition_page.dart';
import 'package:smart_club_app/pages/timer_page/view/timer_page.dart';

class StartSessionButton extends ConsumerWidget {
  const StartSessionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameKey = ref.read(sessionProvider.notifier).globalNameKey;
    final sessionKey = ref.read(sessionProvider.notifier).globalSessionKey;
    final durationKey = ref.read(sessionProvider.notifier).globalDurationKey;
    return ElevatedButton(
      onPressed: () async {
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
        Music selectedMusic = ref.read(musicProvider).firstWhere(
              (music) => music.isSelected,
            );
        ref.read(sessionProvider.notifier).updateSession();
        bool isAsset = selectedMusic.isAsset;
        await ref
            .read(audioPlayerProvider.notifier)
            .setSource(selectedMusic.url, isAsset: isAsset);
        ref.read(audioPlayerProvider.notifier).play();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TimerPage()),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Will work soon on it ')));
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

class BtnAddDevice extends StatelessWidget {
  const BtnAddDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddDevicesTab(),
        ));
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
        'Add Devices',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BtnAddMusic extends StatelessWidget {
  const BtnAddMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MusicAdditionPage()),
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
        'Add Music',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
