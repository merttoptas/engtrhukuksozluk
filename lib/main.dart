import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/data/database/database.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/screens/homeScreen.dart';
import 'package:engtrhukuksozluk/utils/const.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  final favoriteDatabase = await $FloorFavoriteDatabase
        .databaseBuilder('favorite.db')
        .build();

  final favoriteDao = favoriteDatabase.favoriteDao;
  runApp(MyApp(favoriteDao));
}

class MyApp extends StatelessWidget {
  FirebaseAnalytics analytics = FirebaseAnalytics();
  bool isDark = false;

  MyApp(this.favoriteDao);
  final FavoriteDao favoriteDao;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: isDark ? Constants.darkTheme: Constants.lightTheme,
      home:  HomeScreen(favoriteDao),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),

      ],

    );
  }
}



