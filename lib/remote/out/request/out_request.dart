import 'package:json_annotation/json_annotation.dart';

part 'out_request.g.dart';

@JsonSerializable()
class OutRequest {
  final String reason;
  final DateTime startAt;
  final DateTime endAt;
  final bool? isDinner;

  OutRequest({
    required this.reason,
    required this.startAt,
    required this.endAt,
    this.isDinner,
  });

  /// JSON → 객체 변환
  factory OutRequest.fromJson(Map<String, dynamic> json) =>
      _$OutRequestFromJson(json);

  /// 객체 → JSON 변환
  Map<String, dynamic> toJson() => _$OutRequestToJson(this);
}
