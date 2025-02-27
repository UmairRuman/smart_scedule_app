import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/new_deviceType_addition_notifier.dart';
import 'package:smart_club_app/util/maping_functions.dart';

class FirebaseServices {
  static DeviceCollection deviceCollection = DeviceCollection();

  static Future<void> addDevice(
      {required String deviceType,
      required Map<String, dynamic> attribute,
      WidgetRef? ref}) async {
    final deviceName = ref!
            .read(newDevicetypeAdditionProvider.notifier)
            .controllers[deviceType]
            ?.text ??
        '';
    log('Device Added: $deviceType | Name: $deviceName | Attribute: $attribute');
    var listOfDevices = await deviceCollection.getAllDevices("user1");
    Device device = Device(
      type: deviceType,
      status: deviceType == "Bulb" ? "0x0200" : "0x0100",
      deviceName: deviceName,
      deviceId: "0${listOfDevices.length + 1} ${deviceName}",
    );
    await deviceCollection.addDevice(userId: "user1", device: device);
    await getAllDevices();
  }

  static Future<List<Device>> getAllDevices() async {
    log("In get all Devices method");
    // Set loading state before fetching data
    try {
      List<Device> devicesList = await deviceCollection.getAllDevices("user1");
      return devicesList;
    } catch (e) {
      log("Error getting all devices: $e");
      return [];
    }
  }

  // Update device state
  void updateDeviceStateFromFetchedDevices(Device device) {
    final attribute = getDeviceAttributeAccordingToDeviceType(device.type);
    log("Device status = ${device.status}, map Device type = ${mapDeviceType(device.type)}");
  }

  // For deleting the device from firebase
  static Future<void> deleteDevice(String deviceName, String deviceId) async {
    log('Device Deleted: $deviceName | ID: $deviceId');
    await deviceCollection.deleteDevice("user1", deviceId);
  }

  static Future<void> updateDeviceStatusOnToggleSwtich(
      String userId, Device device, String command) async {
    log("command in update Device status method: $command");
    log("device Id  update Device status method: ${device.deviceId}");
    await deviceCollection.updateDeviceStatus(userId, device.deviceId, command);
  }

  static Future<void> updateDeviceStatusOnChangingSlider(String userId,
      Device device, String command, String attributeType) async {
    await deviceCollection.updateDeviceAttribute(
        userId, device.deviceId, command, attributeType);
  }
}
