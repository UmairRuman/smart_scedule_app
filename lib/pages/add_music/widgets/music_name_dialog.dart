import 'package:flutter/material.dart';

Future<String?> showMusicNameInputDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: const Text("Enter Music Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Music Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  Navigator.of(context).pop(controller.text.trim());
                } else {
                  // Show error if the name is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Music name cannot be empty!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      );
    },
  );
}
