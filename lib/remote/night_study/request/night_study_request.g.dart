// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_study_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NightStudyRequest _$NightStudyRequestFromJson(Map<String, dynamic> json) =>
    NightStudyRequest(
      place: json['place'] as String,
      content: json['content'] as String,
      doNeedPhone: json['doNeedPhone'] as bool,
      reasonForPhone: json['reasonForPhone'] as String,
      endAt: json['endAt'] as String,
      startAt: json['startAt'] as String,
    );

Map<String, dynamic> _$NightStudyRequestToJson(NightStudyRequest instance) =>
    <String, dynamic>{
      'place': instance.place,
      'content': instance.content,
      'doNeedPhone': instance.doNeedPhone,
      'reasonForPhone': instance.reasonForPhone,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
    };
