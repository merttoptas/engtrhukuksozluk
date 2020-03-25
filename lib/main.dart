import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/data/database/database.dart';
import 'package:engtrhukuksozluk/screens/splash_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:engtrhukuksozluk/screens/home/home_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  final favoriteDatabase = await $FloorFavoriteDatabase
        .databaseBuilder('favorite.db')
        .build();

  final favoriteDao = favoriteDatabase.favoriteDao;
  runApp(MyApp(favoriteDao: favoriteDao,));
}

class MyApp extends StatelessWidget {
  MyApp({this.favoriteDao, Key key}): super(key:key);
  final FavoriteDao favoriteDao;

  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final bool isDark = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    //theme: isDark ? Constants.darkTheme: Constants.lightTheme,
      theme: ThemeData(
        backgroundColor: AppConstant.lightBG,
        textTheme: TextTheme(
          body1: TextStyle(fontSize: AppConstant.fontSizeBody),
          body2: TextStyle(fontSize: AppConstant.fontSizeBody2,fontWeight: FontWeight.bold),
          caption: TextStyle(fontSize: AppConstant.fontSizeCaption, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: AppConstant.fontSizeDisplay, fontWeight: FontWeight.bold),
          display1: TextStyle(fontSize: AppConstant.fontSizeDisplay, fontWeight: FontWeight.bold),


        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
     ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      initialRoute: AppConstant.pageSplash,
      routes: {
        AppConstant.pageSplash: (context) => SplashScreen(favoriteDao),
        AppConstant.pageHome: (context) => HomeScreen(favoriteDao: favoriteDao,),
      },

    );
  }
}
