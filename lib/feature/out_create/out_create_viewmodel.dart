import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_entity.dart';
import 'package:flutter/material.dart';

class OutCreateViewModel with ChangeNotifier {
  Future<bool> createOut({
    required String title,
    required String reason,
    required TimeOfDay startAt,
    required TimeOfDay endAt,
  }) async {
    final database = await DatabaseManager.getDatabase();
    await database.outDao.insertOutEntity(OutEntity(
      title: title,
      reason: reason,
      startAt: startAt,
      endAt: endAt,
    ));

    print(await database.outDao.findAllEntities());

    return true;
  }
}
