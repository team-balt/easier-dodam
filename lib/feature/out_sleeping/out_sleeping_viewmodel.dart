import 'dart:async';

import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_sleeping_entity.dart';
import 'package:easier_dodam/remote/out_sleeping/response/out_sleeping_response.dart';
import 'package:flutter/cupertino.dart';

import '../../remote/out_sleeping/out_sleeping_data_source.dart';

class OutSleepingViewModel with ChangeNotifier {
  late final OutSleepingDataSource _sleepingDataSource;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<OutSleepingEntity> _sleepingEntities = List.empty();
  List<OutSleepingEntity> get sleepingEntities => _sleepingEntities;

  List<OutSleepingResponse> _sleepingResponses = List.empty();
  List<OutSleepingResponse> get sleepingResponses => _sleepingResponses;

  StreamSubscription<List<OutSleepingEntity>>? _localSubscription;

  OutSleepingViewModel() {
    _sleepingDataSource = OutSleepingDataSource();
    getMySleepings();
    _getSleepingEntities();
  }

  void _getSleepingEntities() async {
    final database = await DatabaseManager.getDatabase();
    _localSubscription =
        database.outSleepingDao.findAllEntitiesWithStream().listen((data) {
      _sleepingEntities = data;
      notifyListeners();
    });
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.outSleepingDao.deleteOutSleepingEntityById(id);
  }

  Future<void> getMySleepings() async {
    setIsLoading(true);
    final sleepings = await _sleepingDataSource.getMyOutSleeping();
    setIsLoading(false);
    _sleepingResponses = sleepings;
    notifyListeners();
  }

  void deleteMySleeping(int id) async {
    setIsLoading(true);
    await _sleepingDataSource.deleteMyOutSleeping(id);
    _sleepingResponses.removeWhere((data) => data.id == id);
    setIsLoading(false);
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> requestSleeping(OutSleepingEntity sleepingEntity) async {
    await _sleepingDataSource.postOutSleeping(sleepingEntity.reason,
        sleepingEntity.startAt as String, sleepingEntity.endAt as String);

    getMySleepings();
    return true;
  }

  @override
  void dispose() {
    _localSubscription?.cancel();
    super.dispose();
  }
}
