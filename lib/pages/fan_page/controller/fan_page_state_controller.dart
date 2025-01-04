import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/collections/device_collection.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';

final fansPageStateProvider =
    NotifierProvider<FansPageStateController, FanPageStates>(
        FansPageStateController.new);

class FansPageStateController extends Notifier<FanPageStates> {
  DeviceCollection deviceCollection = DeviceCollection();
  @override
  FanPageStates build() {
    return FanPageIntialState();
  }

  void getAllFans(String deviceType) async {
    state = FanPageLoadingState();
    try {
      var listOfDevices =
          await deviceCollection.getAllDevicesByType(globalUserId, deviceType);
      state = FanPageLoadedState(listOfDevices: listOfDevices);
    } catch (e) {
      log("Error in getting fans in FanPageStateController ${e.toString()}");
      state = FanPageErrorState(error: e.toString());
    }
  }
}

abstract class FanPageStates {
  const FanPageStates();
}

class FanPageIntialState extends FanPageStates {}

class FanPageLoadingState extends FanPageStates {}

class FanPageLoadedState extends FanPageStates {
  final List<Device> listOfDevices;
  const FanPageLoadedState({required this.listOfDevices});
}

class FanPageErrorState extends FanPageStates {
  final String error;
  const FanPageErrorState({required this.error});
}
