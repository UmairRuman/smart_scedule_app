import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/Notifiers/music_player_notifier.dart';
import 'package:smart_club_app/Notifiers/music_player_provider.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';

class SessionState {
  final String key;
  final String name;
  final int duration; // in minutes

  SessionState({required this.key, required this.name, required this.duration});
}

class SessionNotifier extends Notifier<SessionState?> {
  DeviceCollection deviceCollection = DeviceCollection();
  //Text Editting controllers
  TextEditingController nameTEC = TextEditingController();
  TextEditingController keyTEC = TextEditingController();
  TextEditingController durationTEC = TextEditingController();
  //Global keys for validation
  final globalNameKey = GlobalKey<FormState>();
  final globalDurationKey = GlobalKey<FormState>();
  final globalSessionKey = GlobalKey<FormState>();

  @override
  SessionState? build() {
    ref.onDispose(() {
      nameTEC.dispose();
      keyTEC.dispose();
      durationTEC.dispose();
    });
    return null;
  }

  void updateSession() {
    state = SessionState(
        key: keyTEC.text,
        name: nameTEC.text,
        duration: int.parse(durationTEC.text));
  }

  void clearSession() async {
    nameTEC.clear();
    keyTEC.clear();
    durationTEC.clear();
    ref.read(audioPlayerProvider.notifier).stop();
    ref.read(musicProvider.notifier).unSelectAllMusic();
    // await turningOfAllDevices();
    state = null;
  }

  Future<void> turningOfAllDevices() async {
    List<Device> listOfdevice =
        await deviceCollection.getAllDevices(globalUserId);
    for (Device device in listOfdevice) {
      await deviceCollection.updateDeviceStatus(globalUserId, device.deviceId,
          device.type == "Fan" ? "0x0100" : "0x0200");
    }
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, SessionState?>(
  () => SessionNotifier(),
);
