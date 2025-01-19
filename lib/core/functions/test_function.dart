import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> testFileAccess() async {
  try {
    final data = await rootBundle.load('assets/certificates/client.key');
    log("File loaded successfully: ${data.lengthInBytes} bytes");
  } catch (e) {
    log("Error loading file: $e");
  }
}

Future<void> loadCertificateAndUseIt() async {
  try {
    // Load the certificate as a string
    final certificateData =
        await rootBundle.loadString('assets/certificates/mosquitto.org.crt');
    log("Certificate loaded successfully: ${certificateData.length} characters");

    // Pass the certificate string to the relevant function
    SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificatesBytes(certificateData.codeUnits);

    log("Certificate successfully set in SecurityContext");
  } catch (e) {
    log("Error loading certificate: $e");
  }
}

Future<String> writeAssetToFile(String assetPath, String fileName) async {
  final byteData = await rootBundle.load(assetPath);
  final file = File('${(await getTemporaryDirectory()).path}/$fileName');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file.path;
}
