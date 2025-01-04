// Through RriverPod

import 'package:smart_club_app/model/device.dart';

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
