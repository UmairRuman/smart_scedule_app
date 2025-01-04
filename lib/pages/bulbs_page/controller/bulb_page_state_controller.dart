import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';

final bulbsPageStateProvider =
    NotifierProvider<BulbsPageStateController, BulbPageStates>(
        BulbsPageStateController.new);

class BulbsPageStateController extends Notifier<BulbPageStates> {
  DeviceCollection deviceCollection = DeviceCollection();
  @override
  BulbPageStates build() {
    return BulbPageIntialState();
  }

  void getAllBulbs(String deviceType) async {
    state = BulbPageLoadingState();
    try {
      var listOfDevices =
          await deviceCollection.getAllDevicesByType(globalUserId, deviceType);
      state = BulbPageLoadedState(listOfDevices: listOfDevices);
    } catch (e) {
      log("Error in getting fans in FanPageStateController ${e.toString()}");
      state = BulbPageErrorState(error: e.toString());
    }
  }
}

abstract class BulbPageStates {
  const BulbPageStates();
}

class BulbPageIntialState extends BulbPageStates {}

class BulbPageLoadingState extends BulbPageStates {}

class BulbPageLoadedState extends BulbPageStates {
  final List<Device> listOfDevices;
  const BulbPageLoadedState({required this.listOfDevices});
}

class BulbPageErrorState extends BulbPageStates {
  final String error;
  const BulbPageErrorState({required this.error});
}
