import 'dart:async';

import 'package:easier_dodam/local/conventer/date_time_conveter.dart';
import 'package:easier_dodam/local/dao/out_dao.dart';
import 'package:easier_dodam/local/dao/out_sleeping_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'conventer/time_of_day_converter.dart';
import 'entity/out_entity.dart';
import 'entity/out_sleeping_entity.dart';

part "easier_dodam_database.g.dart";

@TypeConverters([TimeOfDayConverter, DateTimeConverter])
@Database(version: 1, entities: [OutEntity, OutSleepingEntity])
abstract class EasierDodamDatabase extends FloorDatabase {
  OutDao get outDao;
  OutSleepingDao get outSleepingDao;
}
