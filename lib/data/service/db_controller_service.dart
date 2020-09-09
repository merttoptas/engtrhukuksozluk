import '../../model/Favorite.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/model/History.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DBController extends GetxService {
  DBController(this.favoriteDao);
  final FavoriteDao favoriteDao;
  final favorite = Favorite().obs;
  final history = History().obs;
  List<Favorite> favoriteList = [];
  List<Favorite> favExistsList = [];

  Future<void> wordExists(
      Favorite patient, int favId, BuildContext context) async {
    final favoriteDatabase = await $FloorFavoriteDatabase
        .databaseBuilder(AppConstant.favoriteDatabase)
        .build();
    final favoriteDao = favoriteDatabase.favoriteDao;

    await favoriteDao.getAllFavoriteWords().then((list) {
      favoriteList.addAll(list);
    });
    favoriteList.toList();

    await favoriteDao.getId(favId).then((list) {
      favExistsList.addAll(list);
    });

    if (favExistsList.toList().isNotEmpty) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppConstant.favSnackBarNegative),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      );
    } else {
      insertWord(patient, context);
    }
  }

  Future<void> insertWord(favorite, BuildContext context) async {
    final favoriteDatabase = await $FloorFavoriteDatabase
        .databaseBuilder(AppConstant.favoriteDatabase)
        .build();
    final favoriteDao = favoriteDatabase.favoriteDao;
    await favoriteDao.insertFavoriteWord(favorite);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(AppConstant.favSnackBarPositive),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );
  }

  Future<void> deleteHistory() async {
    final historyDatabase = await $FloorHistoryDatabase
        .databaseBuilder(AppConstant.historyDatabase)
        .build();
    final historyDao = historyDatabase.historyDao;

    await historyDao.deleteHistoryWord();
  }

  Future<void> insertHistoryWord(History history) async {
    final historyDatabase = await $FloorHistoryDatabase
        .databaseBuilder(AppConstant.historyDatabase)
        .build();
    final historyDao = historyDatabase.historyDao;
    return await historyDao.insertHistoryWord(history);
  }
}
