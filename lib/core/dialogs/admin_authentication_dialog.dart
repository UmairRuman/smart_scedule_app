import 'package:flutter/material.dart';

Widget adminAuthenticationDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text(
      'Admin Authentication',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
    ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Please enter the admin key to enable edit mode.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
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
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final textFieldValue = (context as Element)
                  .findAncestorWidgetOfExactType<TextField>()
                  ?.controller
                  ?.text;
              Navigator.of(context).pop(textFieldValue);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}
