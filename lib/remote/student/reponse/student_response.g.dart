// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentResponse _$StudentResponseFromJson(Map<String, dynamic> json) =>
    StudentResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      grade: (json['grade'] as num).toInt(),
      room: (json['room'] as num).toInt(),
      number: (json['number'] as num).toInt(),
    );

Map<String, dynamic> _$StudentResponseToJson(StudentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'grade': instance.grade,
      'room': instance.room,
      'number': instance.number,
    };
