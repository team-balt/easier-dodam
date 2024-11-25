import 'dart:async';

import 'package:easier_dodam/feature/night_study/item/night_study_item.dart';
import 'package:flutter/cupertino.dart';

import '../../local/database_manager.dart';
import '../../local/entity/night_study_entity.dart';
import '../../remote/core/base_response.dart';
import '../../remote/night_study/night_study_data_source.dart';
import '../../remote/night_study/response/night_study_response.dart';

class NightStudyViewmodel with ChangeNotifier {
  late NightStudyDataSource _nightStudyDataSource;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NightStudyEntity> _nightStudyEntities = List.empty();
  List<NightStudyEntity> get nightStudyEntities => _nightStudyEntities;

  List<NightStudyResponse> _nightStudyResponses = List.empty();
  List<NightStudyResponse> get nightStudyResponses => _nightStudyResponses;

  StreamSubscription<List<NightStudyEntity>>? _nightStudyStreamSubscription;

  NightStudyViewmodel() {
    _nightStudyDataSource = NightStudyDataSource();
    _getNightStudyEntities();
  }

  void _getNightStudyEntities() async {
    final database = await DatabaseManager.getDatabase();
    _nightStudyStreamSubscription = database.nightStudyDao.findAllEntitiesWithStream().listen((data) {
      _nightStudyEntities = data;
      notifyListeners();
    });
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.nightStudyDao.deleteNightStudyEntityById(id);
  }

  Future<void> getMyNightStudies() async {
    setIsLoading(true);
    final nightStudies = await _nightStudyDataSource.getMyNightStudies();
    setIsLoading(false);
    _nightStudyResponses = nightStudies;
    notifyListeners();
  }

  void deleteMyOut(int id) async {
    setIsLoading(true);
    await _nightStudyDataSource.deleteMyNightStudy(id);
    _nightStudyResponses.removeWhere((data) => data.id == id);
    setIsLoading(false);
    notifyListeners();
  }

  Future<bool> nightStudy(NightStudyEntity nightStudyEntity) async {
        await _nightStudyDataSource.postNightStudy(
            nightStudyEntity.title,
            nightStudyEntity.reason,
            nightStudyEntity.place,
            nightStudyEntity.content,
            nightStudyEntity.doNeedPhone,
            nightStudyEntity.reasonForPhone,
            nightStudyEntity.startAt,
            nightStudyEntity.endAt
        );
    notifyListeners();
    return true;
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  @override
  void dispose() {
    _nightStudyStreamSubscription?.cancel();
    super.dispose();
  }
}