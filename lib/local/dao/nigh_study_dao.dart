import 'package:floor/floor.dart';

import '../entity/night_study_entity.dart';

@dao
abstract class NighStudyDao {
  @Query('SELECT * FROM $_tableName WHERE id = :id')
  Future<NightStudyEntity?> findNightStudyEntityById(int id);

  @Query('SELECT * FROM $_tableName')
  Future<List<NightStudyEntity>> findAllEntities();

  @Query('SELECT * FROM $_tableName')
  Stream<List<NightStudyEntity>> findAllEntitiesWithStream();

  @Query('DELETE FROM $_tableName WHERE id = :id')
  Future<void> deleteNightStudyEntityById(int id);

  @insert
  Future<void> insertNightStudyEntity(NightStudyEntity nightStudyEntity);

  @update
  Future<void> updateNightStudyEntity(NightStudyEntity nightStudyEntity);

  @delete
  Future<void> deleteNightStudyEntity(NightStudyEntity nightStudyEntity);

  @Query("DELETE FROM night_study")
  Future<void> deleteAllNightStudyEntities();

  static const String _tableName = "night_study";
}