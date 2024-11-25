// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_study_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NightStudyResponse _$NightStudyResponseFromJson(Map<String, dynamic> json) =>
    NightStudyResponse(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      allowCheck: $enumDecode(_$StatusEnumMap, json['allowCheck']),
      isPhone: json['isPhone'] as bool,
      reason: json['reason'] as String,
      student:
          StudentResponse.fromJson(json['student'] as Map<String, dynamic>),
      place: json['place'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      checkedAt: json['checkedAt'] == null
          ? null
          : DateTime.parse(json['checkedAt'] as String),
    );

Map<String, dynamic> _$NightStudyResponseToJson(NightStudyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'allowCheck': _$StatusEnumMap[instance.allowCheck]!,
      'isPhone': instance.isPhone,
      'reason': instance.reason,
      'student': instance.student,
      'place': instance.place,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'checkedAt': instance.checkedAt?.toIso8601String(),
    };

const _$StatusEnumMap = {
  Status.ALLOWED: 'ALLOWED',
  Status.PENDING: 'PENDING',
  Status.REJECTED: 'REJECTED',
};
