import 'easier_dodam_database.dart';

abstract class DatabaseManager {
  DatabaseManager._();

  static EasierDodamDatabase? _database;

  static Future<EasierDodamDatabase> getDatabase() async {
    if (_database == null) {
      _database = await $FloorEasierDodamDatabase
          .databaseBuilder('easier_dodam_database.db')
          .build();
      ;
    }
    return _database!;
  }
}
