import 'package:floor/floor.dart';

import '../../feature/night_study/item/night_study_item.dart';

@Entity(tableName: "night_study")
class NightStudyEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;

  final String reason;

  final PlaceType place;

  final String content;

  final bool doNeedPhone;

  final String reasonForPhone;

  final DateTime startAt;

  final DateTime endAt;

  NightStudyEntity({
    this.id,
    required this.title,
    required this.reason,
    required this.place,
    required this.content,
    required this.doNeedPhone,
    required this.reasonForPhone,
    required this.startAt,
    required this.endAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NightStudyEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              reason == other.reason &&
              place == other.place &&
              content == other.content &&
              doNeedPhone == other.doNeedPhone &&
              reasonForPhone == other.reasonForPhone &&
              startAt == other.startAt &&
              endAt == other.endAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      reason.hashCode ^
      place.hashCode ^
      content.hashCode ^
      doNeedPhone.hashCode ^
      reasonForPhone.hashCode ^
      startAt.hashCode ^
      endAt.hashCode;

  @override
  String toString() {
    return 'NightStudyEntity(id: $id, title: $title, reason: $reason, place: $place, content: $content, doNeedPhone: $doNeedPhone, reasonForPhone: $reasonForPhone, startAt: $startAt, endAt: $endAt)';
  }
}