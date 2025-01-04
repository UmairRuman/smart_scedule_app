import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/switch_state_controller.dart';

class DeviceStatus extends ConsumerWidget {
  final Device device;
  final ThemeData theme;
  const DeviceStatus({super.key, required this.device, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(switchStateProvider);
    return Text(
      ref
                  .read(switchStateProvider.notifier)
                  .mapOfSwitchStates[device.deviceId] ==
              true
          ? "On"
          : "OFF",
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: ref
                    .read(switchStateProvider.notifier)
                    .mapOfSwitchStates[device.deviceId] ==
                true
            ? Colors.green
            : Colors.red,
      ),
    );
  }
}
