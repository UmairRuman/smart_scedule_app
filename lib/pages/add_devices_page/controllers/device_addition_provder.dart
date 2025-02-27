import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/controllers/all_device_state_controller.dart';
import 'package:smart_club_app/core/dialogs/progress_dialog.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/new_deviceType_addition_notifier.dart';
import 'package:smart_club_app/util/hexa_into_number.dart';

// Define the NotifierProvider
final deviceAdditionProvider = NotifierProvider<DeviceAdditionNotifier, String>(
  DeviceAdditionNotifier.new,
);

// DeviceAdditionNotifier class
class DeviceAdditionNotifier extends Notifier<String> {
  final DeviceCollection deviceCollection = DeviceCollection();

  String deviceType = 'Bulb';
  String deviceGroup = 'Null';
  String deviceCurrentStatus = "Off";

  @override
  String build() {
    // No state to initialize since this is a side-effect notifier
    return "";
  }

  // Method to add a device
  Future<void> addDevice(
      {required String deviceType,
      required WidgetRef ref,
      required BuildContext context}) async {
    showProgressDialog(context: context, message: "Adding new Device");
    var deviceName = ref
            .read(newDevicetypeAdditionProvider.notifier)
            .controllers[deviceType]!
            .text ??
        "NDevice";
    var list = await deviceCollection.getAllDevices(globalUserId);
    int getDeviceId = int.parse(list[list.length - 1].deviceId[1]);
    final device = Device(
      type: deviceType,
      status: deviceType == "Fan" ? "0x0100" : "0x0200",
      deviceName: deviceName,
      deviceId: "0${getDeviceId + 1} $deviceName",
    );

    await deviceCollection.addDevice(userId: globalUserId, device: device);
    await ref.read(allDeviceStateProvider.notifier).getAlldevices();
    Navigator.of(context).pop();
    // Notify UI components to update, if needed
    state = "Change";
  }
}
