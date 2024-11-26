import 'package:easier_dodam/remote/student/reponse/student_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'night_study_response.g.dart';

enum Status { ALLOWED, PENDING, REJECTED }

@JsonSerializable()
class NightStudyResponse {
  int id;
  String content;
  Status status;
  bool doNeedPhone;
  String? reasonForPhone;
  StudentResponse student;
  String? rejectReason;
  String place;
  DateTime startAt;
  DateTime endAt;
  DateTime createdAt;
  DateTime? modifiedAt;

  NightStudyResponse(
      {
        required this.id,
        required this.content,
        required this.status,
        required this.doNeedPhone,
        this.reasonForPhone,
        required this.student,
        this.rejectReason,
        required this.place,
        required this.startAt,
        required this.endAt,
        required this.createdAt,
        this.modifiedAt
      }
  );

  factory NightStudyResponse.fromJson(Map<String, dynamic> json) =>
      _$NightStudyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NightStudyResponseToJson(this);

}