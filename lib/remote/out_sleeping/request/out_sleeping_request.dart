import 'package:json_annotation/json_annotation.dart';

part 'out_sleeping_request.g.dart';

@JsonSerializable()
class OutSleepingRequest {
  final String reason;
  final String startAt;
  final String endAt;

  OutSleepingRequest({
    required this.reason,
    required this.startAt,
    required this.endAt,
  });

  /// JSON → 객체 변환
  factory OutSleepingRequest.fromJson(Map<String, dynamic> json) =>
      _$OutSleepingRequestFromJson(json);

  /// 객체 → JSON 변환
  Map<String, dynamic> toJson() => _$OutSleepingRequestToJson(this);
}
