import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import '../../feature/night_study/item/night_study_item.dart';

@Entity(tableName: "night_study")
class NightStudyEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final PlaceType place;

  final String content;

  final bool doNeedPhone;

  final String reasonForPhone;

  final TimeOfDay startAt;

  final TimeOfDay endAt;

  NightStudyEntity({
    this.id,
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
              place == other.place &&
              content == other.content &&
              doNeedPhone == other.doNeedPhone &&
              reasonForPhone == other.reasonForPhone &&
              startAt == other.startAt &&
              endAt == other.endAt;

  @override
  int get hashCode =>
      id.hashCode ^
      place.hashCode ^
      content.hashCode ^
      doNeedPhone.hashCode ^
      reasonForPhone.hashCode ^
      startAt.hashCode ^
      endAt.hashCode;

  @override
  String toString() {
    return 'NightStudyEntity(id: $id, place: $place, content: $content, doNeedPhone: $doNeedPhone, reasonForPhone: $reasonForPhone, startAt: $startAt, endAt: $endAt)';
  }
}