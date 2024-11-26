// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_study_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NightStudyResponse _$NightStudyResponseFromJson(Map<String, dynamic> json) =>
    NightStudyResponse(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      doNeedPhone: json['doNeedPhone'] as bool,
      reasonForPhone: json['reasonForPhone'] as String?,
      student:
          StudentResponse.fromJson(json['student'] as Map<String, dynamic>),
      rejectReason: json['rejectReason'] as String?,
      place: json['place'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$NightStudyResponseToJson(NightStudyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'status': _$StatusEnumMap[instance.status]!,
      'doNeedPhone': instance.doNeedPhone,
      'reasonForPhone': instance.reasonForPhone,
      'student': instance.student,
      'rejectReason': instance.rejectReason,
      'place': instance.place,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };

const _$StatusEnumMap = {
  Status.ALLOWED: 'ALLOWED',
  Status.PENDING: 'PENDING',
  Status.REJECTED: 'REJECTED',
};
