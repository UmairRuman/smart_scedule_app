import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminModeProvider =
    NotifierProvider<AdminModeNotifier, bool>(AdminModeNotifier.new);

class AdminModeNotifier extends Notifier<bool> {
  TextEditingController adminKeyController = TextEditingController();
  @override
  bool build() {
    ref.onDispose(() {
      adminKeyController.dispose();
    });
    return false;
  }

  void toggleAdminMode(BuildContext context) async {
    state = !state;
    clearAdminKeyController();
  }

  void clearAdminKeyController() {
    adminKeyController.clear();
  }
}
