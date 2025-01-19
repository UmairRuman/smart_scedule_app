import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/core/dialogs/progress_dialog.dart';
import 'package:smart_club_app/core/services/service_locater.dart';
import 'package:smart_club_app/core/services/shared_prefrence_Service.dart';
import 'package:smart_club_app/pages/session_selection_page/controller/admin_mode_state_cotroller.dart';

Future<bool> adminAuthenticationDialog(
    BuildContext context, WidgetRef ref) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Admin Authentication',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please enter the admin key to enable edit mode.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller:
                    ref.read(adminModeProvider.notifier).adminKeyController,
                decoration: InputDecoration(
                  hintText: 'Enter Admin Key',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.tealAccent, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      showProgressDialog(
                          context: context, message: "Validating admin key");
                      String adminKey = await serviceLocator
                          .get<SharedPrefrenceService>()
                          .getAdminKeyFromPrefs();

                      if (ref
                              .read(adminModeProvider.notifier)
                              .adminKeyController
                              .text ==
                          adminKey) {
                        Navigator.pop(context); // Close progress dialog
                        Navigator.pop(
                            context, true); // Return true if authenticated
                      } else {
                        ref
                            .read(adminModeProvider.notifier)
                            .clearAdminKeyController();
                        Navigator.pop(context); // Close progress dialog
                        Navigator.pop(context, false); // Return false if failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid admin key'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    onPressed: () {
                      ref
                          .read(adminModeProvider.notifier)
                          .clearAdminKeyController();
                      Navigator.pop(context, false); // Return false on cancel
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  // Handle null result (dialog dismissed without pressing Submit)
  return result ?? false;
}
