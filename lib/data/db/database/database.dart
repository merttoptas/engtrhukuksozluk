import 'dart:async';
import 'package:engtrhukuksozluk/data/db/dao/historyDao.dart';
import 'package:engtrhukuksozluk/model/history.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';
import 'package:engtrhukuksozluk/model/favorite.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Favorite])
abstract class FavoriteDatabase extends FloorDatabase {
  FavoriteDao get favoriteDao;
}

@Database(version: 1, entities: [History])
abstract class HistoryDatabase extends FloorDatabase {
  HistoryDao get historyDao;
}
