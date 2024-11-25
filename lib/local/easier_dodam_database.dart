import 'dart:async';

import 'package:easier_dodam/local/dao/nigh_study_dao.dart';
import 'package:easier_dodam/local/dao/out_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../feature/night_study/item/night_study_item.dart';
import '../feature/night_study/item/night_study_present_item.dart';
import 'conventer/time_of_day_converter.dart';
import 'entity/night_study_entity.dart';
import 'entity/out_entity.dart';

part "easier_dodam_database.g.dart";

@TypeConverters([TimeOfDayConverter])
@Database(version: 1, entities: [OutEntity, NightStudyEntity])
abstract class EasierDodamDatabase extends FloorDatabase {
  OutDao get outDao;
  NighStudyDao get nightStudyDao;
}
