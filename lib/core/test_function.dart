import 'dart:developer';

import 'package:flutter/services.dart';

Future<void> testFileAccess() async {
  try {
    final data = await rootBundle.load('assets/music/energetics.mp3');
    log("File loaded successfully: ${data.lengthInBytes} bytes");
  } catch (e) {
    log("Error loading file: $e");
  }
}
