import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_club_app/controllers/session_notifier.dart';
import 'package:smart_club_app/pages/welcome_page/view/welcome_page.dart'; // For animations

void endSessionManually(BuildContext context, WidgetRef ref) {
  final session = ref.read(sessionProvider);

  if (session != null) {
    showDialog(
      context: context,
      builder: (context) {
        String enteredKey = '';

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blueGrey, Colors.black87],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Add an animation at the top
                    Lottie.asset(
                      'assets/animation/warning.json', // Include a Lottie animation file
                      height: 80,
                      width: 80,
                      repeat: true,
                    ),

                    const Text(
                      'End Session',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const Text(
                      'Enter the session key to confirm ending this session.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),

                    TextField(
                      onChanged: (value) {
                        enteredKey = value;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Enter Session Key',
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black45,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: const Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black45,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (enteredKey == session.key) {
                              Navigator.pop(context); // Close the dialog
                              navigateToWelcomePage(context, ref);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid Session Key'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle,
                              color: Colors.green),
                          label: const Text('Confirm'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void navigateToWelcomePage(BuildContext context, WidgetRef ref) {
  ref.read(sessionProvider.notifier).clearSession();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const WelcomePage()),
    (route) => false,
  );
}
