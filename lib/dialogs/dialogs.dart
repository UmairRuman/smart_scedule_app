import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Admin Password'),
      content: const TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: 'Password'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle admin logout
            Navigator.pop(context);
          },
          child: const Text('Unlock'),
        ),
      ],
    ),
  );
}
