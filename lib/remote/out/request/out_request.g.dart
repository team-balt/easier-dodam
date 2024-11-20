// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'out_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutRequest _$OutRequestFromJson(Map<String, dynamic> json) => OutRequest(
      reason: json['reason'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      isDinner: json['isDinner'] as bool?,
    );

Map<String, dynamic> _$OutRequestToJson(OutRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'isDinner': instance.isDinner,
    };
