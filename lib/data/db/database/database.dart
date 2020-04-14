import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Favorite])
abstract class FavoriteDatabase extends FloorDatabase {
  FavoriteDao get favoriteDao;
}