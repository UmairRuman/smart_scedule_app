class Device {
  final String deviceId;
  final String deviceName;
  final String type;
  final String status;

  Device({
    required this.deviceId,
    required this.deviceName,
    required this.type,
    required this.status,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'type': type,
      'status': status,
    };
  }
}
