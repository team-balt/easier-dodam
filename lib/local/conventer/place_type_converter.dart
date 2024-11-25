import 'package:floor/floor.dart';

import '../../feature/night_study/item/night_study_item.dart';

class PlaceTypeConverter extends TypeConverter<PlaceType, String> {
  @override
  PlaceType decode(String databaseValue) {
    return PlaceType.values.firstWhere((e) => e.toString() == 'PlaceType.' + databaseValue);
  }

  @override
  String encode(PlaceType value) {
    return value.toString().split('.').last;
  }
}