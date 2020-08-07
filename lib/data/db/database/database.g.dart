// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFavoriteDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavoriteDatabaseBuilder databaseBuilder(String name) =>
      _$FavoriteDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavoriteDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FavoriteDatabaseBuilder(null);
}

class _$FavoriteDatabaseBuilder {
  _$FavoriteDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FavoriteDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FavoriteDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FavoriteDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$FavoriteDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FavoriteDatabase extends FavoriteDatabase {
  _$FavoriteDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoriteDao _favoriteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Favorite` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `favWordsEng` TEXT, `favWordsTr` TEXT, `favId` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  FavoriteDao get favoriteDao {
    return _favoriteDaoInstance ??= _$FavoriteDao(database, changeListener);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _favoriteInsertionAdapter = InsertionAdapter(
            database,
            'Favorite',
            (Favorite item) => <String, dynamic>{
                  'id': item.id,
                  'favWordsEng': item.english,
                  'favWordsTr': item.turkish,
                  'favId': item.favId
                },
            changeListener),
        _favoriteDeletionAdapter = DeletionAdapter(
            database,
            'Favorite',
            ['id'],
            (Favorite item) => <String, dynamic>{
                  'id': item.id,
                  'favWordsEng': item.english,
                  'favWordsTr': item.turkish,
                  'favId': item.favId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _favoriteMapper = (Map<String, dynamic> row) => Favorite(
      id: row['id'] as int,
      turkish: row['favWordsTr'] as String,
      english: row['favWordsEng'] as String,
      favId: row['favId'] as int);

  final InsertionAdapter<Favorite> _favoriteInsertionAdapter;

  final DeletionAdapter<Favorite> _favoriteDeletionAdapter;

  @override
  Future<List<Favorite>> getAllFavoriteWords() async {
    return _queryAdapter.queryList('SELECT * FROM favorite',
        mapper: _favoriteMapper);
  }

  @override
  Future<List<Favorite>> getId(int favWord) async {
    return _queryAdapter.queryList('SELECT * FROM favorite WHERE favId = ?',
        arguments: <dynamic>[favWord], mapper: _favoriteMapper);
  }

  @override
  Stream<List<Favorite>> findAllFavoriteStream() {
    return _queryAdapter.queryListStream('SELECT * FROM favorite',
        tableName: 'Favorite', mapper: _favoriteMapper);
  }

  @override
  Future<List<Favorite>> findFavoriteWord(String favWordsEng) async {
    return _queryAdapter.queryList(
        'SELECT * FROM favorite WHERE favWordsEng = ?',
        arguments: <dynamic>[favWordsEng],
        mapper: _favoriteMapper);
  }

  @override
  Future<void> insertFavoriteWord(Favorite favorite) async {
    await _favoriteInsertionAdapter.insert(
        favorite, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteFavWord(Favorite favorite) async {
    await _favoriteDeletionAdapter.delete(favorite);
  }

  @override
  Future<void> deleteFavWords(List<Favorite> favorite) async {
    await _favoriteDeletionAdapter.deleteList(favorite);
  }
}

class $FloorHistoryDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$HistoryDatabaseBuilder databaseBuilder(String name) =>
      _$HistoryDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$HistoryDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$HistoryDatabaseBuilder(null);
}

class _$HistoryDatabaseBuilder {
  _$HistoryDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$HistoryDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$HistoryDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<HistoryDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$HistoryDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$HistoryDatabase extends HistoryDatabase {
  _$HistoryDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HistoryDao _historyDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `historyWord` TEXT, `historyId` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _historyInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (History item) => <String, dynamic>{
                  'id': item.id,
                  'historyWord': item.historyWord,
                  'historyId': item.historyId
                },
            changeListener),
        _historyDeletionAdapter = DeletionAdapter(
            database,
            'History',
            ['id'],
            (History item) => <String, dynamic>{
                  'id': item.id,
                  'historyWord': item.historyWord,
                  'historyId': item.historyId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _historyMapper = (Map<String, dynamic> row) => History(
      id: row['id'] as int,
      historyWord: row['historyWord'] as String,
      historyId: row['historyId'] as int);

  final InsertionAdapter<History> _historyInsertionAdapter;

  final DeletionAdapter<History> _historyDeletionAdapter;

  @override
  Future<List<History>> getAllHistoryWords() async {
    return _queryAdapter.queryList('SELECT * FROM history',
        mapper: _historyMapper);
  }

  @override
  Future<List<History>> getId(int historyWord) async {
    return _queryAdapter.queryList('SELECT * FROM history WHERE historyId = ?',
        arguments: <dynamic>[historyWord], mapper: _historyMapper);
  }

  @override
  Stream<List<History>> findAllHistoryStream() {
    return _queryAdapter.queryListStream('SELECT * FROM history',
        tableName: 'History', mapper: _historyMapper);
  }

  @override
  Future<void> deleteHistoryWord() async {
    await _queryAdapter.queryNoReturn('DELETE FROM history');
  }

  @override
  Future<List<History>> findHistoryWord(String historyWord) async {
    return _queryAdapter.queryList(
        'SELECT * FROM history WHERE historyWord = ?',
        arguments: <dynamic>[historyWord],
        mapper: _historyMapper);
  }

  @override
  Future<void> insertHistoryWord(History history) async {
    await _historyInsertionAdapter.insert(
        history, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteHistoryWords(List<History> history) async {
    await _historyDeletionAdapter.deleteList(history);
  }
}
