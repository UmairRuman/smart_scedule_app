import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/controllers/all_device_state_controller.dart';
import 'package:smart_club_app/core/dialogs/progress_dialog.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/fan_page/controller/fan_page_state_controller.dart';

void showFanRemovalConfirmationDialog(
  Device device,
  BuildContext context,
  WidgetRef ref,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Fan"),
        content: Text("Are you sure you want to delete ${device.deviceName}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              showProgressDialog(
                  context: context, message: "Deleting ${device.deviceName}");

              await ref
                  .read(fansPageStateProvider.notifier)
                  .deleteFan(device.deviceName, device.deviceId, device.type);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.tealAccent, // Customize delete button color
            ),
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}

void showDeviceRemovalConfirmationDialog(
  Device device,
  BuildContext context,
  WidgetRef ref,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete device"),
        content: Text("Are you sure you want to delete ${device.deviceName}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              showProgressDialog(
                  context: context,
                  message: "Deleting device ${device.deviceName}");
              await ref
                  .read(allDeviceStateProvider.notifier)
                  .deleteDevice(device.deviceId);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.tealAccent, // Customize delete button color
            ),
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
