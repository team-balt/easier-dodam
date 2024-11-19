import 'dart:ffi';

import 'package:easier_dodam/local/entity/out_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class OutDao {
  @Query('SELECT * FROM $_tableName WHERE id = :id')
  Future<OutEntity?> findOutEntityById(int id);

  @Query('SELECT * FROM $_tableName')
  Future<List<OutEntity>> findAllEntities();

  @Query('SELECT * FROM $_tableName')
  Stream<List<OutEntity>> findAllEntitiesWithStream();

  @Query('DELETE FROM $_tableName WHERE id = :id')
  Future<void> deleteOutEntityById(int id);

  @insert
  Future<void> insertOutEntity(OutEntity outEntity);

  @update
  Future<void> updateOutEntity(OutEntity outEntity);

  @delete
  Future<void> deleteOutEntity(OutEntity outEntity);

  @Query("DELETE FROM note")
  Future<void> deleteAllOutEntities();

  static const String _tableName = "out";
}
