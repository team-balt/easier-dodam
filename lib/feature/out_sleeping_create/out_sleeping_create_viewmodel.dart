import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_sleeping_entity.dart';
import 'package:flutter/material.dart';

class OutSleepingCreateViewModel with ChangeNotifier {
  Future<bool> createSleeping({
    required String title,
    required String reason,
    required String startDate,
    required String endDate,
  }) async {
    final database = await DatabaseManager.getDatabase();
    await database.outSleepingDao.insertOutSleepingEntity(OutSleepingEntity(
        title: title, reason: reason, startAt: startDate, endAt: endDate));
    return true;
  }
}
