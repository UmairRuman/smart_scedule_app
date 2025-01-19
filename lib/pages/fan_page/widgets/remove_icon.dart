import 'dart:developer';

import 'package:flutter/material.dart';

class FanPageRemoveIcon extends StatelessWidget {
  const FanPageRemoveIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.remove_circle,
      size: 35,
      color: Colors.red,
    );
  }
}
