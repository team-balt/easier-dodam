import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(tableName: "out")
class OutEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;

  final String reason;

  final TimeOfDay startAt;

  final TimeOfDay endAt;

  OutEntity({
    this.id,
    required this.title,
    required this.reason,
    required this.startAt,
    required this.endAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          reason == other.reason &&
          startAt == other.startAt &&
          endAt == other.endAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      reason.hashCode ^
      startAt.hashCode ^
      endAt.hashCode;

  @override
  String toString() {
    return 'OutEntity(id: $id, title: $title, reason: $reason, startAt: $startAt, endAt: $endAt)';
  }
}
