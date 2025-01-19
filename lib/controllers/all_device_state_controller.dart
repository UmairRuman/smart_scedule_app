import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';

final allDeviceStateProvider =
    NotifierProvider<DeviceStateChangeNotifier, DeviceDataStates>(
        DeviceStateChangeNotifier.new);

class DeviceStateChangeNotifier extends Notifier<DeviceDataStates> {
  DeviceCollection deviceCollection = DeviceCollection();
  @override
  DeviceDataStates build() {
    return DeviceDataInitialState();
  }

  Future<void> getAlldevices() async {
    await Future.delayed(const Duration(seconds: 1));
    state = DeviceDataLoadingState();
    try {
      var listOfDevices = await deviceCollection.getAllDevices(globalUserId);
      state = DeviceDataLoadedState(list: listOfDevices);
    } catch (e) {
      state = DeviceDataErrorState(error: e.toString());
      log("Error getting all devices: ${e.toString()}");
    }
  }

  Future<void> deleteDevice(String deviceId) async {
    try {
      await deviceCollection.deleteDevice(globalUserId, deviceId);
      await getAlldevices();
    } catch (e) {
      log("Error deleting device: ${e.toString()}");
    }
  }
}

abstract class DeviceDataStates {}

class DeviceDataInitialState extends DeviceDataStates {}

class DeviceDataLoadingState extends DeviceDataStates {}

class DeviceDataLoadedState extends DeviceDataStates {
  final List<Device> list;
  DeviceDataLoadedState({required this.list});
}

class DeviceDataErrorState extends DeviceDataStates {
  final String error;
  DeviceDataErrorState({required this.error});
}
