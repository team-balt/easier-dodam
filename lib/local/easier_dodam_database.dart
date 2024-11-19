import 'dart:async';

import 'package:easier_dodam/local/dao/out_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'conventer/time_of_day_converter.dart';
import 'entity/out_entity.dart';

part "easier_dodam_database.g.dart";

@TypeConverters([TimeOfDayConverter])
@Database(version: 1, entities: [OutEntity])
abstract class EasierDodamDatabase extends FloorDatabase {
  OutDao get outDao;
}
