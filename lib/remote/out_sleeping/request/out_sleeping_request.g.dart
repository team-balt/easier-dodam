// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'out_sleeping_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutSleepingRequest _$OutSleepingRequestFromJson(Map<String, dynamic> json) =>
    OutSleepingRequest(
      reason: json['reason'] as String,
      startAt: json['startAt'] as String,
      endAt: json['endAt'] as String,
    );

Map<String, dynamic> _$OutSleepingRequestToJson(OutSleepingRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
    };
