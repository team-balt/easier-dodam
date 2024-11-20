import 'dart:async';

import 'package:easier_dodam/local/database_manager.dart';
import 'package:easier_dodam/local/entity/out_entity.dart';
import 'package:flutter/cupertino.dart';

class OutViewModel with ChangeNotifier {
  List<OutEntity> _outEntities = List.empty();
  List<OutEntity> get outEntities => _outEntities;

  StreamSubscription<List<OutEntity>>? _subscription;

  OutViewModel() {
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

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
