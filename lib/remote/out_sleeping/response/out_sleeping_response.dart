import 'package:json_annotation/json_annotation.dart';

part 'out_sleeping_response.g.dart';

enum OutSleepingStatus { ALLOWED, PENDING, REJECTED }

@JsonSerializable()
class OutSleepingResponse {
  final int id;
  final String reason;
  final OutSleepingStatus status;
  final String? rejectReason;
  final String startAt;
  final String endAt;
  final String createdAt;
  final String modifiedAt;

  OutSleepingResponse({
    required this.id,
    required this.reason,
    required this.status,
    this.rejectReason,
    required this.startAt,
    required this.endAt,
    required this.createdAt,
    required this.modifiedAt,
  });

  /// JSON → 객체 변환
  factory OutSleepingResponse.fromJson(Map<String, dynamic> json) =>
      _$OutSleepingResponseFromJson(json);

  /// 객체 → JSON 변환
  Map<String, dynamic> toJson() => _$OutSleepingResponseToJson(this);
}
