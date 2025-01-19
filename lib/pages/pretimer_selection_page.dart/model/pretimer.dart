// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pretimer {
  final String pretimerId;
  final int pretimerDuration;
  Pretimer({
    required this.pretimerId,
    required this.pretimerDuration,
  });

  Pretimer copyWith({
    String? pretimerId,
    int? pretimerDuration,
  }) {
    return Pretimer(
      pretimerId: pretimerId ?? this.pretimerId,
      pretimerDuration: pretimerDuration ?? this.pretimerDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pretimerId': pretimerId,
      'pretimerDuration': pretimerDuration,
    };
  }

  factory Pretimer.fromMap(Map<String, dynamic> map) {
    return Pretimer(
      pretimerId: map['pretimerId'] as String,
      pretimerDuration: map['pretimerDuration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pretimer.fromJson(String source) =>
      Pretimer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Pretimer(pretimerId: $pretimerId, pretimerDuration: $pretimerDuration)';

  @override
  bool operator ==(covariant Pretimer other) {
    if (identical(this, other)) return true;

    return other.pretimerId == pretimerId &&
        other.pretimerDuration == pretimerDuration;
  }

  @override
  int get hashCode => pretimerId.hashCode ^ pretimerDuration.hashCode;
}

class PretimerConstants {
  static const String twoMinuteTimer = "2 Minutes";
  static const String fiveMinuteTimer = "5 Minutes";
  static const String tenMinuteTimer = "10 Minutes";
}
