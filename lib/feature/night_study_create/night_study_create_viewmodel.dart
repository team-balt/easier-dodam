import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/night_study_entity.dart';
import 'package:flutter/material.dart';

import '../night_study/item/night_study_item.dart';


class NightStudyCreateViewModel with ChangeNotifier {
  Future<bool> createNightStudy({
    required PlaceType place,
    required String title,
    required String content,
    required bool doNeedPhone,
    required String reasonForPhone,
    required DateTime startAt,
    required DateTime endAt
  }) async {
    final database = await DatabaseManager.getDatabase();
    await database.nightStudyDao.insertNightStudyEntity(NightStudyEntity(
        title: title,
        place: place,
        content: content,
        doNeedPhone: doNeedPhone,
        reasonForPhone: reasonForPhone,
        startAt: startAt,
        endAt: endAt
    ));

    print(await database.nightStudyDao.findAllEntities());

    return true;
  }
}
