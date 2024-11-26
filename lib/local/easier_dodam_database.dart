import 'dart:async';

import 'package:easier_dodam/local/dao/nigh_study_dao.dart';
import 'package:easier_dodam/local/dao/out_dao.dart';
import 'package:easier_dodam/local/dao/out_sleeping_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'conventer/date_time_conveter.dart';
import 'conventer/place_type_converter.dart';
import 'conventer/time_of_day_converter.dart';
import 'entity/night_study_entity.dart';
import 'entity/out_entity.dart';
import 'entity/out_sleeping_entity.dart';

part "easier_dodam_database.g.dart";

@TypeConverters([TimeOfDayConverter, DateTimeConverter, PlaceTypeConverter])
@Database(version: 1, entities: [OutEntity, NightStudyEntity, OutSleepingEntity])
abstract class EasierDodamDatabase extends FloorDatabase {
  OutDao get outDao;
  NighStudyDao get nightStudyDao;
  OutSleepingDao get outSleepingDao;
}