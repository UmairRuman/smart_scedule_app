import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/core/global_functions.dart';

final adminModeProvider =
    NotifierProvider<AdminModeNotifier, bool>(AdminModeNotifier.new);

class AdminModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<void> toggleAdminMode(BuildContext context) async {
    if (!state) {
      // Require session/admin ID to enable edit mode
      final adminKey = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enter Admin Key'),
          content: SingleChildScrollView(
            child: TextField(
              decoration: const InputDecoration(hintText: 'Admin Key'),
              onSubmitted: (value) => Navigator.of(context).pop(value),
            ),
          ),
        ),
      );

      if (adminKey == await getAdminKey()) {
        state = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid session/admin key')),
        );
      }
    } else {
      state = false;
    }
  }
}
