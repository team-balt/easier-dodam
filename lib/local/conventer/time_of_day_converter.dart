import 'package:flutter/material.dart';
import 'package:floor/floor.dart';

class TimeOfDayConverter extends TypeConverter<TimeOfDay, String> {
  @override
  TimeOfDay decode(String databaseValue) {
    final parts = databaseValue.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String encode(TimeOfDay value) {
    return '${value.hour}:${value.minute}';
  }
}
