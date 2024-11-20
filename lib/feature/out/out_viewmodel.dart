import 'dart:async';

import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_entity.dart';
import 'package:easier_dodam/remote/out/response/out_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../remote/out/out_data_source.dart';

class OutViewModel with ChangeNotifier {
  late final OutDataSource _outDataSource;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  Future<void> getMyOuts() async {
    setIsLoading(true);
    final outs = await _outDataSource.getMyOuts();
    setIsLoading(false);
    _outResponses = outs;
    notifyListeners();
  }

  void deleteMyOut(int id) async {
    print("delete start");
    await _outDataSource.deleteMyOut(id);
    _outResponses.removeWhere((data) => data.id == id);
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> requestOut(OutEntity outEntity) async {
    await _outDataSource.postOut(
      outEntity.reason,
      timeOfDayToDateTime(outEntity.startAt),
      timeOfDayToDateTime(outEntity.endAt),
    );

    getMyOuts();
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
