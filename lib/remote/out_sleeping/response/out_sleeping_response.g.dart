// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'out_sleeping_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutSleepingResponse _$OutSleepingResponseFromJson(Map<String, dynamic> json) =>
    OutSleepingResponse(
      id: (json['id'] as num).toInt(),
      reason: json['reason'] as String,
      status: $enumDecode(_$OutSleepingStatusEnumMap, json['status']),
      rejectReason: json['rejectReason'] as String?,
      startAt: json['startAt'] as String,
      endAt: json['endAt'] as String,
      createdAt: json['createdAt'] as String,
      modifiedAt: json['modifiedAt'] as String,
    );

Map<String, dynamic> _$OutSleepingResponseToJson(
        OutSleepingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reason': instance.reason,
      'status': _$OutSleepingStatusEnumMap[instance.status]!,
      'rejectReason': instance.rejectReason,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
    };

const _$OutSleepingStatusEnumMap = {
  OutSleepingStatus.ALLOWED: 'ALLOWED',
  OutSleepingStatus.PENDING: 'PENDING',
  OutSleepingStatus.REJECTED: 'REJECTED',
};
