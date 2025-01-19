import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/core/dialogs/progress_dialog.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/device_addition_provder.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/new_deviceType_addition_notifier.dart';
import 'package:smart_club_app/util/icons.dart';

class AddDevicesTab extends ConsumerWidget {
  const AddDevicesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(newDevicetypeAdditionProvider);
    final theme = Theme.of(context);
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Devices",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal, // Teal color for the app bar
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
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 7, 78, 71)
                                .withOpacity(0.8),
                            const Color.fromARGB(255, 25, 144, 116)
                                .withOpacity(0.8),
                            const Color.fromARGB(255, 10, 169, 132)
                                .withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: isTablet ? 40 : 30,
                              backgroundColor: Colors.tealAccent,
                              child: Icon(
                                getDeviceIcon(device['deviceType']),
                                color: Colors.black,
                                size: isTablet ? 30 : 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: device['controller'],
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  color: Colors.teal.shade900,
                                ),
                                decoration: InputDecoration(
                                  labelText: "${device['deviceType']} Name",
                                  labelStyle: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 142, 128, 128),
                                    fontSize: isTablet ? 18 : 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.tealAccent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.teal.shade700,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                showProgressDialog(
                                    context: context,
                                    message:
                                        "Adding Device ${device['deviceType']}");

                                await ref
                                    .read(deviceAdditionProvider.notifier)
                                    .addDevice(
                                        deviceType: device['deviceType'],
                                        ref: ref,
                                        context: context);
                                ref
                                    .read(
                                        newDevicetypeAdditionProvider.notifier)
                                    .clearDevicesTextFields();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.tealAccent.shade700,
                                padding: EdgeInsets.symmetric(
                                  vertical: isTablet ? 16 : 12,
                                  horizontal: isTablet ? 20 : 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 236, 229, 229),
                                ),
                              ),
                            ),
                          ],
                        ),
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
