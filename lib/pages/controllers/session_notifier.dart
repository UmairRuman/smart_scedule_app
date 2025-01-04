import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionState {
  final String key;
  final String name;
  final int duration; // in minutes

  SessionState({required this.key, required this.name, required this.duration});
}

class SessionNotifier extends Notifier<SessionState?> {
  //Text Editting controllers
  TextEditingController nameTEC = TextEditingController();
  TextEditingController keyTEC = TextEditingController();
  TextEditingController durationTEC = TextEditingController();
  //Global keys for validation
  final globalNameKey = GlobalKey<FormState>();
  final globalDurationKey = GlobalKey<FormState>();
  final globalSessionKey = GlobalKey<FormState>();

  @override
  SessionState? build() => null;

  void updateSession() {
    state = SessionState(
        key: "123456", name: "Umair Ruman", duration: int.parse("10"));
  }

  void clearSession() {
    state = null;
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, SessionState?>(
  () => SessionNotifier(),
);
