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

  NighStudyDao? _nightStudyDaoInstance;

  OutSleepingDao? _outSleepingDaoInstance;

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
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `night_study` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `place` TEXT NOT NULL, `content` TEXT NOT NULL, `doNeedPhone` INTEGER NOT NULL, `reasonForPhone` TEXT NOT NULL, `startAt` TEXT NOT NULL, `endAt` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `out_sleeping` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `reason` TEXT NOT NULL, `startAt` TEXT NOT NULL, `endAt` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OutDao get outDao {
    return _outDaoInstance ??= _$OutDao(database, changeListener);
  }

  @override
  NighStudyDao get nightStudyDao {
    return _nightStudyDaoInstance ??= _$NighStudyDao(database, changeListener);
  }

  @override
  OutSleepingDao get outSleepingDao {
    return _outSleepingDaoInstance ??=
        _$OutSleepingDao(database, changeListener);
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

class _$NighStudyDao extends NighStudyDao {
  _$NighStudyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _nightStudyEntityInsertionAdapter = InsertionAdapter(
            database,
            'night_study',
            (NightStudyEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'place': _placeTypeConverter.encode(item.place),
                  'content': item.content,
                  'doNeedPhone': item.doNeedPhone ? 1 : 0,
                  'reasonForPhone': item.reasonForPhone,
                  'startAt': _dateTimeConverter.encode(item.startAt),
                  'endAt': _dateTimeConverter.encode(item.endAt)
                },
            changeListener),
        _nightStudyEntityUpdateAdapter = UpdateAdapter(
            database,
            'night_study',
            ['id'],
            (NightStudyEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'place': _placeTypeConverter.encode(item.place),
                  'content': item.content,
                  'doNeedPhone': item.doNeedPhone ? 1 : 0,
                  'reasonForPhone': item.reasonForPhone,
                  'startAt': _dateTimeConverter.encode(item.startAt),
                  'endAt': _dateTimeConverter.encode(item.endAt)
                },
            changeListener),
        _nightStudyEntityDeletionAdapter = DeletionAdapter(
            database,
            'night_study',
            ['id'],
            (NightStudyEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'place': _placeTypeConverter.encode(item.place),
                  'content': item.content,
                  'doNeedPhone': item.doNeedPhone ? 1 : 0,
                  'reasonForPhone': item.reasonForPhone,
                  'startAt': _dateTimeConverter.encode(item.startAt),
                  'endAt': _dateTimeConverter.encode(item.endAt)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NightStudyEntity> _nightStudyEntityInsertionAdapter;

  final UpdateAdapter<NightStudyEntity> _nightStudyEntityUpdateAdapter;

  final DeletionAdapter<NightStudyEntity> _nightStudyEntityDeletionAdapter;

  @override
  Future<NightStudyEntity?> findNightStudyEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM night_study WHERE id = ?1',
        mapper: (Map<String, Object?> row) => NightStudyEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            place: _placeTypeConverter.decode(row['place'] as String),
            content: row['content'] as String,
            doNeedPhone: (row['doNeedPhone'] as int) != 0,
            reasonForPhone: row['reasonForPhone'] as String,
            startAt: _dateTimeConverter.decode(row['startAt'] as String),
            endAt: _dateTimeConverter.decode(row['endAt'] as String)),
        arguments: [id]);
  }

  @override
  Future<List<NightStudyEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM night_study',
        mapper: (Map<String, Object?> row) => NightStudyEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            place: _placeTypeConverter.decode(row['place'] as String),
            content: row['content'] as String,
            doNeedPhone: (row['doNeedPhone'] as int) != 0,
            reasonForPhone: row['reasonForPhone'] as String,
            startAt: _dateTimeConverter.decode(row['startAt'] as String),
            endAt: _dateTimeConverter.decode(row['endAt'] as String)));
  }

  @override
  Stream<List<NightStudyEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM night_study',
        mapper: (Map<String, Object?> row) => NightStudyEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            place: _placeTypeConverter.decode(row['place'] as String),
            content: row['content'] as String,
            doNeedPhone: (row['doNeedPhone'] as int) != 0,
            reasonForPhone: row['reasonForPhone'] as String,
            startAt: _dateTimeConverter.decode(row['startAt'] as String),
            endAt: _dateTimeConverter.decode(row['endAt'] as String)),
        queryableName: 'night_study',
        isView: false);
  }

  @override
  Future<void> deleteNightStudyEntityById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM night_study WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAllNightStudyEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM night_study');
  }

  @override
  Future<void> insertNightStudyEntity(NightStudyEntity nightStudyEntity) async {
    await _nightStudyEntityInsertionAdapter.insert(
        nightStudyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNightStudyEntity(NightStudyEntity nightStudyEntity) async {
    await _nightStudyEntityUpdateAdapter.update(
        nightStudyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNightStudyEntity(NightStudyEntity nightStudyEntity) async {
    await _nightStudyEntityDeletionAdapter.delete(nightStudyEntity);
  }
}

class _$OutSleepingDao extends OutSleepingDao {
  _$OutSleepingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _outSleepingEntityInsertionAdapter = InsertionAdapter(
            database,
            'out_sleeping',
            (OutSleepingEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'reason': item.reason,
                  'startAt': item.startAt,
                  'endAt': item.endAt
                },
            changeListener),
        _outSleepingEntityUpdateAdapter = UpdateAdapter(
            database,
            'out_sleeping',
            ['id'],
            (OutSleepingEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'reason': item.reason,
                  'startAt': item.startAt,
                  'endAt': item.endAt
                },
            changeListener),
        _outSleepingEntityDeletionAdapter = DeletionAdapter(
            database,
            'out_sleeping',
            ['id'],
            (OutSleepingEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'reason': item.reason,
                  'startAt': item.startAt,
                  'endAt': item.endAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OutSleepingEntity> _outSleepingEntityInsertionAdapter;

  final UpdateAdapter<OutSleepingEntity> _outSleepingEntityUpdateAdapter;

  final DeletionAdapter<OutSleepingEntity> _outSleepingEntityDeletionAdapter;

  @override
  Future<OutSleepingEntity?> findOutSleepingEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM out_sleeping WHERE id = ?1',
        mapper: (Map<String, Object?> row) => OutSleepingEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            reason: row['reason'] as String,
            startAt: row['startAt'] as String,
            endAt: row['endAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<OutSleepingEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM out_sleeping',
        mapper: (Map<String, Object?> row) => OutSleepingEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            reason: row['reason'] as String,
            startAt: row['startAt'] as String,
            endAt: row['endAt'] as String));
  }

  @override
  Stream<List<OutSleepingEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM out_sleeping',
        mapper: (Map<String, Object?> row) => OutSleepingEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            reason: row['reason'] as String,
            startAt: row['startAt'] as String,
            endAt: row['endAt'] as String),
        queryableName: 'out_sleeping',
        isView: false);
  }

  @override
  Future<void> deleteOutSleepingEntityById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM out_sleeping WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAllOutSleepingEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM out_sleeping');
  }

  @override
  Future<void> insertOutSleepingEntity(
      OutSleepingEntity outSleepingEntity) async {
    await _outSleepingEntityInsertionAdapter.insert(
        outSleepingEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOutSleepingEntity(
      OutSleepingEntity outSleepingEntity) async {
    await _outSleepingEntityUpdateAdapter.update(
        outSleepingEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOutSleepingEntity(
      OutSleepingEntity outSleepingEntity) async {
    await _outSleepingEntityDeletionAdapter.delete(outSleepingEntity);
  }
}

// ignore_for_file: unused_element
final _timeOfDayConverter = TimeOfDayConverter();
final _dateTimeConverter = DateTimeConverter();
final _placeTypeConverter = PlaceTypeConverter();
