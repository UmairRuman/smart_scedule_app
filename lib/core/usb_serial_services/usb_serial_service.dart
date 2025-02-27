import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:smart_club_app/model/device.dart';
import 'package:usb_serial/usb_serial.dart';

class UsbSerialService {
  List<UsbDevice> devices = [];
  UsbPort? port;
  Future<List<UsbDevice>> getListOfDevices() async {
    devices = await UsbSerial.listDevices();
    log("Devices");
    return devices;
  }

  Future<void> createAndInitiallizePort(UsbDevice usbDevice) async {
    port = await usbDevice.create();

    bool openResult = await port!.open();
    if (!openResult) {
      log("Failed to open");
      return;
    }

    await port!.setDTR(true);
    await port!.setRTS(true);

    port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);
  }

  Future<void> listenForIncomingData() async {
    if (port == null) return;
    port!.inputStream!.listen((Uint8List event) {
      log(event.toString());
      port!.close();
    });
  }

  Future<void> writeDataToPort(Device device, UsbDevice usbDevice) async {
    if (port == null) {
      log("Port is not initialized");
      return;
    }

    // Create a combined packet with device and USB port information
    Map<String, dynamic> dataPacket = {
      "usbSerialNumber": usbDevice.deviceId,
      "usbDeviceName": usbDevice.deviceName,
      "deviceMetadata": device.toJson(),
    };

    // Serialize to JSON
    String jsonData = jsonEncode(dataPacket);
    log("Data being written: $jsonData");

    // Convert JSON string to Uint8List
    Uint8List dataToSend = Uint8List.fromList(utf8.encode(jsonData));

    // Write data to the port
    await port!.write(dataToSend);
  }

  Future<void> closePort() async {
    await port!.close();
  }
}
