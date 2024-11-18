// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_study_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NightStudyResponse _$NightStudyResponseFromJson(Map<String, dynamic> json) =>
    NightStudyResponse(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      allowCheck: json['allowCheck'] as String,
      isPhone: json['isPhone'] as bool,
      reason: json['reason'] as String,
      student:
          StudentResponse.fromJson(json['student'] as Map<String, dynamic>),
      place: json['place'] as String,
      startAt: json['startAt'] as String,
      endAt: json['endAt'] as String,
      createdAt: json['createdAt'] as String,
      checkedAt: json['checkedAt'] as String?,
    );

Map<String, dynamic> _$NightStudyResponseToJson(NightStudyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'allowCheck': instance.allowCheck,
      'isPhone': instance.isPhone,
      'reason': instance.reason,
      'student': instance.student,
      'place': instance.place,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'createdAt': instance.createdAt,
      'checkedAt': instance.checkedAt,
    };
