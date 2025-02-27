import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_club_app/core/functions/test_function.dart';
import 'package:smart_club_app/main.dart';

class MqttService {
  static final MqttService _instance = MqttService._internal();

  final MqttServerClient client;
  bool isConnected = false;
  final Duration _reconnectDelay = const Duration(seconds: 1);

  String? username;
  String? password;
  int retryCount = 0;
  final int maxRetries = 5;

  MqttService._internal()
      : client = MqttServerClient('test.mosquitto.org',
            'flutter_client_${DateTime.now().millisecondsSinceEpoch}') {
    client.port = 8883; // Use the secure port
    client.keepAlivePeriod = 30;
    client.secure = true; // Enable secure connection

    // Load the certificates
    Future.wait([
      writeAssetToFile('assets/certificates/mosquitto.org.crt', 'ca.crt'),
      writeAssetToFile('assets/certificates/client.crt', 'client.crt'),
      writeAssetToFile('assets/certificates/client.key', 'client.key'),
    ]).then((filePaths) {
      client.securityContext = SecurityContext.defaultContext
        ..setTrustedCertificates(filePaths[0]) // CA cert
        ..useCertificateChain(filePaths[1]) // Client cert
        ..usePrivateKey(filePaths[2]); // Private key
    });

    client.logging(on: true);
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
  }

  factory MqttService() => _instance;

  // Future<void> initialize(String username, String password) async {
  //   this.username = username;
  //   this.password = password;
  //   client.connectionMessage = MqttConnectMessage()
  //       .withClientIdentifier(
  //           'flutter_client_${DateTime.now().millisecondsSinceEpoch}')
  //       .authenticateAs(username, password);
  // }

  Future<void> connect() async {
    if (isConnected) {
      log('Already connected to MQTT broker.');
      return;
    }

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.values) {
      Fluttertoast.showToast(
          msg: 'No internet connection. MQTT will connect when online.');
      monitorInternetConnectionAndReconnect(); // Wait for internet
      return;
    }

    try {
      log('Attempting to connect to MQTT broker...');
      final connectionFuture = client.connect();
      await connectionFuture.timeout(const Duration(seconds: 10),
          onTimeout: () {
        throw TimeoutException('Connection timed out.');
      });
    } catch (e) {
      log('Error connecting to MQTT broker: $e');
      client.disconnect();
      _scheduleReconnect();
    }
  }

  bool reconnecting = false;
  void _scheduleReconnect() {
    if (reconnecting || retryCount >= maxRetries) return;
    reconnecting = true;

    retryCount++;
    Future.delayed(_reconnectDelay, () async {
      reconnecting = false;
      await connect();
    });
  }

  void _onConnected() {
    log('Successfully connected to the MQTT broker.');
    isConnected = true;
    retryCount = 0;

    // Re-subscribe to topics after successful reconnection
    final userId = globalUserId; // Replace with dynamic user ID
    final topic = 'user/$userId/device/+/status'; // Example topic
    const topic2 = "user123/+/init";
    subscribeToTopic(topic);
    subscribeToTopic(topic2);
  }

  void _onDisconnected() {
    log('Disconnected from the MQTT broker.');
    isConnected = false;

    if (client.connectionStatus?.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      log('Disconnection was requested by the client.');
    } else {
      Fluttertoast.showToast(
          msg: 'MQTT disconnected unexpectedly. Reconnecting...');
    }

    // Wait for reconnection only when the internet is restored
    monitorInternetConnectionAndReconnect();
  }

  void monitorInternetConnectionAndReconnect() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none && !isConnected) {
        log('Internet connection restored. Attempting to reconnect...');
        Fluttertoast.showToast(
          msg: 'Internet restored. Reconnecting to MQTT...',
        );
        connect(); // Attempt reconnection
      } else if (result == ConnectivityResult.values) {
        Fluttertoast.showToast(
          msg: 'No internet connection.',
        );
      }
    });
  }

  void subscribeToTopic(String topic) {
    if (!isConnected) {
      log('Unable to subscribe. Client not connected.');
      return;
    }

    log('Subscribing to topic: $topic');
    client.subscribe(topic, MqttQos.exactlyOnce);

    // Add a filtering mechanism for the topic
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (c == null || c.isEmpty) return;

      final receivedTopic =
          c[0].topic; // Extract the topic from the received message
      log("Data receiving topic  $receivedTopic");
      // if (receivedTopic != topic) {
      //   return; // Ignore messages for topics other than the current one
      // }

      try {
        final recMessage = c[0].payload as MqttPublishMessage;
        final message = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);
        log('Received message on topic $receivedTopic: $message');
        // Fluttertoast.showToast(msg: 'Device Update: $message');
      } catch (e) {
        log('Error processing received message: $e');
      }
    });
  }

  void publishMessage(String topic, String message) {
    if (!isConnected) {
      Fluttertoast.showToast(msg: 'MQTT is not connected. Cannot publish.');
      return;
    }

    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    log('Message published to $topic: $message');
  }
}
