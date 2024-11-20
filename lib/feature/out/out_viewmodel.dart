import 'dart:async';

import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_entity.dart';
import 'package:easier_dodam/remote/out/response/out_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../remote/out/out_data_source.dart';

class OutViewModel with ChangeNotifier {
  late final OutDataSource _outDataSource;

  List<OutEntity> _outEntities = List.empty();
  List<OutEntity> get outEntities => _outEntities;

  List<OutResponse> _outResponses = List.empty();
  List<OutResponse> get outResponses => _outResponses;

  StreamSubscription<List<OutEntity>>? _localSubscription;

  OutViewModel() {
    _outDataSource = OutDataSource();
    getMyOuts();
    _getOutEntities();
  }

  void _getOutEntities() async {
    final database = await DatabaseManager.getDatabase();
    _localSubscription =
        database.outDao.findAllEntitiesWithStream().listen((data) {
      _outEntities = data;
      notifyListeners();
    });
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.outDao.deleteOutEntityById(id);
  }

  void getMyOuts() async {
    final outs = await _outDataSource.getMyOuts();
    _outResponses = outs;
    notifyListeners();
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
    _localSubscription?.cancel();
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
