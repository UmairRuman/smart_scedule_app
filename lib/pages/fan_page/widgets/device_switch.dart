import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/main.dart';
import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/device_state_change_notifier.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/switch_state_controller.dart';
import 'package:smart_club_app/util/hexa_into_number.dart';

class DeviceSwitch extends ConsumerStatefulWidget {
  final Device device;

  const DeviceSwitch({
    super.key,
    required this.device,
  });

  @override
  ConsumerState<DeviceSwitch> createState() => _DeviceSwitchState();
}

class _DeviceSwitchState extends ConsumerState<DeviceSwitch> {
  bool isSwitchOn = false;
  @override
  void initState() {
    super.initState();
    isSwitchOn = GerenrateNumberFromHexa.hexaIntoStringAccordingToDeviceType(
            widget.device.type, widget.device.status) ==
        "On";
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(switchStateProvider.notifier).intialSwitchState(isSwitchOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(switchStateProvider);

    return Switch(
      value: isSwitchOn,
      onChanged: (value) {
        setState(() {
          isSwitchOn = value;
        });
        ref
            .read(deviceStateProvider.notifier)
            .toggleSwitch(value, widget.device, globalUserId, context, ref);
      },
    );
  }
}
