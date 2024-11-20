import 'package:flutter/material.dart';

int timeOfDayDifference(TimeOfDay start, TimeOfDay end) {
  final startMinutes = start.hour * 60 + start.minute;
  final endMinutes = end.hour * 60 + end.minute;

  // 차이를 계산
  final differenceInMinutes = endMinutes - startMinutes;

  // 차이를 Duration으로 변환
  return differenceInMinutes;
}

extension DateTimeToTimeOfDay on DateTime {
  TimeOfDay get timeOfDay {
    return TimeOfDay.fromDateTime(this);
  }
}
