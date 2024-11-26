import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_response.g.dart';

@JsonSerializable()
class StudentResponse extends BaseObject<StudentResponse>{
  int? id;
  String name;
  int grade;
  int room;
  int number;

  StudentResponse({this.id, required this.name, required this.grade, required this.room, required this.number});

  factory StudentResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentResponseFromJson(json);

  @override
  StudentResponse fromJson(json) {
    return StudentResponse.fromJson(json);
  }

}