import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_club_app/controllers/all_device_state_controller.dart';
import 'package:smart_club_app/core/dialogs/device_removal_confirmationDialog.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/session_selection_page/widgets/switch.dart';
import 'package:smart_club_app/util/icons.dart';

class IotControl extends ConsumerWidget {
  final bool isAdminMode;
  const IotControl({super.key, required this.isAdminMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(allDeviceStateProvider);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Builder(builder: (context) {
          if (state is DeviceDataInitialState ||
              state is DeviceDataLoadingState) {
            return SpinKitCircle(
              color: Colors.blue, // Replace with your theme's primary color
              size: 50.0,
            );
          } else if (state is DeviceDataLoadedState) {
            return DeviceLoadedStateWidget(
              devicesList: state.list,
              isAdminMode: isAdminMode,
            );
          } else if (state is DeviceDataErrorState) {
            final error = state.error;
            return Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            );
          } else {
            return Text(
              "Something went wrong",
              style: TextStyle(color: Colors.red, fontSize: 16),
            );
          }
        }),
      ),
    );
  }
}

class DeviceLoadedStateWidget extends ConsumerWidget {
  final List<Device> devicesList;
  final bool isAdminMode;

  const DeviceLoadedStateWidget({
    super.key,
    required this.devicesList,
    required this.isAdminMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap:
          true, // Allows it to be contained inside another scrollable widget
      physics: const NeverScrollableScrollPhysics(), // Prevents inner scrolling
      itemCount: devicesList.length,
      itemBuilder: (context, index) {
        final device = devicesList[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(
                  getDeviceIcon(device.type),
                  color: Colors.tealAccent,
                  size: 40,
                ),
                title: Text(
                  device.deviceName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: isAdminMode
                    ? Row(
                        mainAxisSize: MainAxisSize.min, // Use minimal width
                        children: [
                          DeviceSwitch(device: device),
                          const SizedBox(width: 16), // Add proper spacing
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () async {
                              showDeviceRemovalConfirmationDialog(
                                  device, context, ref);
                              // Handle delete action here
                              // log(
                              //     'Delete icon pressed for ${device.deviceName}');
                            },
                          ),
                        ],
                      )
                    : DeviceSwitch(device: device),
              ),
            ),
            if (index < devicesList.length - 1)
              const Divider(color: Colors.white54),
          ],
        );
      },
    );
  }
}
