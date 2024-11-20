import 'dart:async';

import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../remote/out/out_data_source.dart';

class OutViewModel with ChangeNotifier {
  late final OutDataSource _outDataSource;

  List<OutEntity> _outEntities = List.empty();
  List<OutEntity> get outEntities => _outEntities;

  StreamSubscription<List<OutEntity>>? _subscription;

  OutViewModel() {
    _outDataSource = OutDataSource();
    _getOutEntities();
  }

  void _getOutEntities() async {
    final database = await DatabaseManager.getDatabase();
    _subscription = database.outDao.findAllEntitiesWithStream().listen((data) {
      _outEntities = data;
      notifyListeners();
    });
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.outDao.deleteOutEntityById(id);
  }

  Future<bool> requestOut(OutEntity outEntity) async {
    await _outDataSource.postOut(
      outEntity.reason,
      timeOfDayToDateTime(outEntity.startAt),
      timeOfDayToDateTime(outEntity.endAt),
    );

    return true;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

DateTime timeOfDayToDateTime(TimeOfDay timeOfDay, {DateTime? dateTime}) {
  return dateTime ??
      DateTime.now().copyWith(
        hour: timeOfDay.hour,
        minute: timeOfDay.minute,
      );
}
