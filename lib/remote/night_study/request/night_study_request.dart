import 'package:json_annotation/json_annotation.dart';

part 'night_study_request.g.dart';

@JsonSerializable()
class NightStudyRequest{
  String place;
  String content;
  bool doNeedPhone;
  String reasonForPhone;
  String startAt;
  String endAt;

  NightStudyRequest(
      {
        required this.place,
        required this.content,
        required this.doNeedPhone,
        required this.reasonForPhone,
        required this.endAt,
        required this.startAt
      }
  );

  Map<String, dynamic> toJson() {
    return _$NightStudyRequestToJson(this);
  }
}