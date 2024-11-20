// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutResponse _$OutResponseFromJson(Map<String, dynamic> json) => OutResponse(
      id: (json['id'] as num).toInt(),
      reason: json['reason'] as String,
      status: $enumDecode(_$OutStatusEnumMap, json['status']),
      rejectReason: json['rejectReason'] as String?,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$OutResponseToJson(OutResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reason': instance.reason,
      'status': _$OutStatusEnumMap[instance.status]!,
      'rejectReason': instance.rejectReason,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'modifiedAt': instance.modifiedAt.toIso8601String(),
    };

const _$OutStatusEnumMap = {
  OutStatus.ALLOWED: 'ALLOWED',
  OutStatus.PENDING: 'PENDING',
  OutStatus.REJECTED: 'REJECTED',
};
