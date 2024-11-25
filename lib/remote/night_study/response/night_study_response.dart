import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:easier_dodam/remote/student/reponse/student_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'night_study_response.g.dart';

enum Status { ALLOWED, PENDING, REJECTED }

@JsonSerializable()
class NightStudyResponse {
  int id;
  String content;
  Status allowCheck;
  bool isPhone;
  String reason;
  StudentResponse student;
  String place;
  DateTime startAt;
  DateTime endAt;
  DateTime createdAt;
  DateTime? checkedAt;

  NightStudyResponse(
      {
        required this.id,
        required this.content,
        required this.allowCheck,
        required this.isPhone,
        required this.reason,
        required this.student,
        required this.place,
        required this.startAt,
        required this.endAt,
        required this.createdAt,
        this.checkedAt
      }
  );

  factory NightStudyResponse.fromJson(Map<String, dynamic> json) =>
      _$NightStudyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NightStudyResponseToJson(this);

}