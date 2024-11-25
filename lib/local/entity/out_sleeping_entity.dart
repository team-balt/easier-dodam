import 'package:floor/floor.dart';

import '../conventer/date_time_conveter.dart';

@Entity(tableName: "out_sleeping")
@TypeConverters([DateTimeConverter])
class OutSleepingEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;

  final String reason;

  final String startAt;

  final String endAt;

  OutSleepingEntity({
    this.id,
    required this.title,
    required this.reason,
    required this.startAt,
    required this.endAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutSleepingEntity &&
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
    return 'OutSleepingEntity(id: $id, title: $title, reason: $reason, startAt: $startAt, endAt: $endAt)';
  }
}
