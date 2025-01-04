import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/core/dialogs/admin_authentication_dialog.dart';
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
      // Show a styled dialog for admin key input
      final adminKey = await showDialog<String>(
        context: context,
        builder: (context) {
          return adminAuthenticationDialog(context);
        },
      );

      // Validate the admin key
      if (adminKey == await getAdminKey()) {
        state = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid admin key'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } else {
      state = false;
    }
  }
}
