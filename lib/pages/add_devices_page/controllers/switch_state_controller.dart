import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/util/hexa_into_number.dart';

final switchStateProvider =
    NotifierProvider<SwitchStateController, bool>(SwitchStateController.new);

class SwitchStateController extends Notifier<bool> {
  Map<String, bool> mapOfSwitchStates = {};
  DeviceCollection deviceCollection = DeviceCollection();
  bool isSwitchOn = false;
  @override
  bool build() {
    return isSwitchOn;
  }

  void intialSwitchState(bool value) {
    state = value;
  }

  Future<void> updateSwitchState(bool value, Device device) async {
    var status = await deviceCollection.getDeviceStatus(
        globalUserId, device.deviceId, device.deviceName);
    var genNo = GerenrateNumberFromHexa.hexaIntoStringAccordingToDeviceType(
        device.type, status);

    mapOfSwitchStates[device.deviceId] = genNo == "On";
    log("Lenght of map in updateSwitchState method = ${mapOfSwitchStates.length}");

    log("genNo in Update swtich State method = $genNo");
    log("value = ${genNo == "On"}");
    state = genNo == "On";
  }
}
