import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/device_addition_provder.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/new_deviceType_addition_notifier.dart';
import 'package:smart_club_app/util/icons.dart';

class AddDevicesTab extends ConsumerWidget {
  const AddDevicesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(newDevicetypeAdditionProvider);

    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Devices"),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: theme.cardColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.primaryColor,
                        child: Icon(
                          getDeviceIcon(device['deviceType']),
                          color: theme.iconTheme.color,
                        ),
                      ),
                      title: TextField(
                        controller: device['controller'],
                        decoration: InputDecoration(
                          labelText: "${device['deviceType']} Name",
                          labelStyle: theme.inputDecorationTheme.labelStyle,
                          border: theme.inputDecorationTheme.border,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          ref.read(deviceAdditionProvider.notifier).addDevice(
                              deviceType: device['deviceType'],
                              ref: ref,
                              context: context);
                        },
                        child: Text("Add"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
