// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_study_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NightStudyRequest _$NightStudyRequestFromJson(Map<String, dynamic> json) =>
    NightStudyRequest(
      place: $enumDecode(_$PlaceTypeEnumMap, json['place']),
      content: json['content'] as String,
      doNeedPhone: json['doNeedPhone'] as bool,
      reasonForPhone: json['reasonForPhone'] as String,
      endAt: DateTime.parse(json['endAt'] as String),
      startAt: DateTime.parse(json['startAt'] as String),
    );

Map<String, dynamic> _$NightStudyRequestToJson(NightStudyRequest instance) =>
    <String, dynamic>{
      'place': _$PlaceTypeEnumMap[instance.place]!,
      'content': instance.content,
      'doNeedPhone': instance.doNeedPhone,
      'reasonForPhone': instance.reasonForPhone,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
    };

const _$PlaceTypeEnumMap = {
  PlaceType.PROGRAMMING_1: 'PROGRAMMING_1',
  PlaceType.PROGRAMMING_2: 'PROGRAMMING_2',
  PlaceType.PROGRAMMING_3: 'PROGRAMMING_3',
};
