import 'package:easier_dodam/local/entity/out_sleeping_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class OutSleepingDao {
  @Query('SELECT * FROM $_tableName WHERE id = :id')
  Future<OutSleepingEntity?> findOutSleepingEntityById(int id);

  @Query('SELECT * FROM $_tableName')
  Future<List<OutSleepingEntity>> findAllEntities();

  @Query('SELECT * FROM $_tableName')
  Stream<List<OutSleepingEntity>> findAllEntitiesWithStream();

  @Query('DELETE FROM $_tableName WHERE id = :id')
  Future<void> deleteOutSleepingEntityById(int id);

  @insert
  Future<void> insertOutSleepingEntity(OutSleepingEntity outSleepingEntity);

  @update
  Future<void> updateOutSleepingEntity(OutSleepingEntity outSleepingEntity);

  @delete
  Future<void> deleteOutSleepingEntity(OutSleepingEntity outSleepingEntity);

  @Query("DELETE FROM $_tableName")
  Future<void> deleteAllOutSleepingEntities();

  static const String _tableName = "out_sleeping";
}
