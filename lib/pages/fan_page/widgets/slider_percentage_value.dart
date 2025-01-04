import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_club_app/model/device.dart';
import 'package:smart_club_app/pages/add_devices_page/controllers/slide_value_controller.dart';

class SliderPercentageValue extends ConsumerWidget {
  final Device device;
  final ThemeData theme;

  const SliderPercentageValue({
    super.key,
    required this.device,
    required this.theme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(sliderValueProvider);
    return Text(
      "${ref.read(sliderValueProvider.notifier).mapOfSliderValues[device.deviceId] ?? 0}%",
      style: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
