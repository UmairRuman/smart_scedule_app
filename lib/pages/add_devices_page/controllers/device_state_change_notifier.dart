// Through Riverpod
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/core/dialogs/progress_dialog.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/firebase_services.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/slide_value_controller.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/switch_state_controller.dart';
import 'package:smart_club_app/pages/add_devices_page/model/device_states.dart';
import 'package:smart_club_app/protocol/mqt_service.dart';
import 'package:smart_club_app/util/hexa_into_number.dart';
import 'package:smart_club_app/util/maping_functions.dart';

final deviceStateProvider =
    NotifierProvider<DeviceStateChangeNotifier, DeviceDataStates>(
        DeviceStateChangeNotifier.new);

class DeviceStateChangeNotifier extends Notifier<DeviceDataStates> {
  final MqttService mqttService = MqttService();
  final DeviceCollection deviceCollection = DeviceCollection.instance;
  //Controllers for adding new devices
  final Map<String, TextEditingController> controllers = {};
  @override
  DeviceDataStates build() {
    return DeviceDataInitialState();
  }

  // When the switch is toggeled
  void toggleSwitch(bool value, Device device, String userId,
      BuildContext context, WidgetRef ref) async {
    if (!mqttService.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text("MQTT is not connected. Cannot send the command.")));
      log('MQTT is not connected. Cannot send the command.');
      return;
    }
    showProgressDialog(
        context: context,
        message: "Turning ${device.deviceName} ${value ? "On" : "Off"}");

    var command = getCommand(device.type, value ? "On" : "Off");
    await FirebaseServices.updateDeviceStatusOnToggleSwtich(
        userId, device, command);

    // Fetch updated devices list and update state
    List<Device> list = await deviceCollection.getAllDevices(userId);
    state = DeviceDataLoadedState(list: list);
    await ref
        .read(switchStateProvider.notifier)
        .updateSwitchState(value, device);
    Navigator.of(context).pop();
  }

  void updateSliderValue(
      double value, Device device, String userId, BuildContext context) async {
    if (!mqttService.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text("MQTT is not connected. Cannot send the command.")));
      log('MQTT is not connected. Cannot send the command.');
      return;
    }
    bool isSwitchOn = ref
            .read(switchStateProvider.notifier)
            .mapOfSwitchStates[device.deviceId] ??
        false;
    if (isSwitchOn) {
      showProgressDialog(
          context: context,
          message:
              "Updating ${GerenrateNumberFromHexa.getDeviceAttributeAccordingToDeviceType(device.type)}");

      var command = getCommand(device.type, value.toInt().toString());
      var attributeType = getDeviceAttributeAccordingToDeviceType(device.type);
      await FirebaseServices.updateDeviceStatusOnChangingSlider(
          userId, device, command, attributeType);

      // Fetch updated devices list and update state
      List<Device> list = await deviceCollection.getAllDevices(userId);
      state = DeviceDataLoadedState(list: list);
      await ref
          .read(sliderValueProvider.notifier)
          .updateSliderValue(value, device);

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Switch is off"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> getAllDevices(WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 2));
    state = DeviceDataLoadingState();
    var list = await FirebaseServices.getAllDevices();
    for (var device in list) {
      ref
              .read(switchStateProvider.notifier)
              .mapOfSwitchStates[device.deviceId] =
          GerenrateNumberFromHexa.hexaIntoStringAccordingToDeviceType(
                  device.type, device.status) ==
              "On";

      ref
              .read(sliderValueProvider.notifier)
              .mapOfSliderValues[device.deviceId] =
          double.parse(
              GerenrateNumberFromHexa.hexaIntoStringAccordingToDeviceType(
                  device.type, device.attributes.values.first));
    }
    state = DeviceDataLoadedState(list: list);
  }

  Future<void> deleteAllDevices(Device device, WidgetRef ref) async {
    await FirebaseServices.deleteDevice(device.deviceName, device.deviceId);
  }
}
