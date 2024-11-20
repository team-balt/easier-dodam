import 'package:json_annotation/json_annotation.dart';

part 'out_response.g.dart';

enum OutStatus { ALLOWED, PENDING, REJECTED }

@JsonSerializable()
class OutResponse {
  final int id;
  final String reason;
  final OutStatus status;
  final String? rejectReason;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime createdAt;
  final DateTime modifiedAt;

  OutResponse({
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
  factory OutResponse.fromJson(Map<String, dynamic> json) =>
      _$OutResponseFromJson(json);

  /// 객체 → JSON 변환
  Map<String, dynamic> toJson() => _$OutResponseToJson(this);
}
