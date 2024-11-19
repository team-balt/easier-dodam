// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easier_dodam_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $EasierDodamDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $EasierDodamDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $EasierDodamDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<EasierDodamDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorEasierDodamDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $EasierDodamDatabaseBuilderContract databaseBuilder(String name) =>
      _$EasierDodamDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $EasierDodamDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$EasierDodamDatabaseBuilder(null);
}

class _$EasierDodamDatabaseBuilder
    implements $EasierDodamDatabaseBuilderContract {
  _$EasierDodamDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $EasierDodamDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $EasierDodamDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<EasierDodamDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$EasierDodamDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EasierDodamDatabase extends EasierDodamDatabase {
  _$EasierDodamDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  OutDao? _outDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `out` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `reason` TEXT NOT NULL, `startAt` TEXT NOT NULL, `endAt` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OutDao get outDao {
    return _outDaoInstance ??= _$OutDao(database, changeListener);
  }
}

class _$OutDao extends OutDao {
  _$OutDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _outEntityInsertionAdapter = InsertionAdapter(
            database,
            'out',
            (OutEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'reason': item.reason,
                  'startAt': _timeOfDayConverter.encode(item.startAt),
                  'endAt': _timeOfDayConverter.encode(item.endAt)
                },
            changeListener),
        _outEntityUpdateAdapter = UpdateAdapter(
            database,
            'out',
            ['id'],
            (OutEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'reason': item.reason,
                  'startAt': _timeOfDayConverter.encode(item.startAt),
                  'endAt': _timeOfDayConverter.encode(item.endAt)
                },
            changeListener),
        _outEntityDeletionAdapter = DeletionAdapter(
            database,
            'out',
            ['id'],
            (OutEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'reason': item.reason,
                  'startAt': _timeOfDayConverter.encode(item.startAt),
                  'endAt': _timeOfDayConverter.encode(item.endAt)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OutEntity> _outEntityInsertionAdapter;

  final UpdateAdapter<OutEntity> _outEntityUpdateAdapter;

  final DeletionAdapter<OutEntity> _outEntityDeletionAdapter;

  @override
  Future<OutEntity?> findOutEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM out WHERE id = ?1',
        mapper: (Map<String, Object?> row) => OutEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            reason: row['reason'] as String,
            startAt: _timeOfDayConverter.decode(row['startAt'] as String),
            endAt: _timeOfDayConverter.decode(row['endAt'] as String)),
        arguments: [id]);
  }

  @override
  Future<List<OutEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM out',
        mapper: (Map<String, Object?> row) => OutEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            reason: row['reason'] as String,
            startAt: _timeOfDayConverter.decode(row['startAt'] as String),
            endAt: _timeOfDayConverter.decode(row['endAt'] as String)));
  }

  @override
  Stream<List<OutEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM out',
        mapper: (Map<String, Object?> row) => OutEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            reason: row['reason'] as String,
            startAt: _timeOfDayConverter.decode(row['startAt'] as String),
            endAt: _timeOfDayConverter.decode(row['endAt'] as String)),
        queryableName: 'out',
        isView: false);
  }

  @override
  Future<void> deleteOutEntityById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM out WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllOutEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }

  @override
  Future<void> insertOutEntity(OutEntity outEntity) async {
    await _outEntityInsertionAdapter.insert(
        outEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOutEntity(OutEntity outEntity) async {
    await _outEntityUpdateAdapter.update(outEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOutEntity(OutEntity outEntity) async {
    await _outEntityDeletionAdapter.delete(outEntity);
  }
}

// ignore_for_file: unused_element
final _timeOfDayConverter = TimeOfDayConverter();
