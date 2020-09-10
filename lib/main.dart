import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/data/service/db_controller_service.dart';
import 'package:engtrhukuksozluk/data/service/value_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/ui/screens/intro_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/ui/screens/splash_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:engtrhukuksozluk/ui/screens/home/home_page.dart';

import 'data/db/dao/historyDao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase crash
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  final favoriteDatabase =
      await $FloorFavoriteDatabase.databaseBuilder(AppConstant.favoriteDatabase).build();

  final historyDatabase =
      await $FloorHistoryDatabase.databaseBuilder(AppConstant.historyDatabase).build();

  final favoriteDao = favoriteDatabase.favoriteDao;
  final historyDao = historyDatabase.historyDao;
  runApp(MyApp(
    favoriteDao: favoriteDao,
    historyDao: historyDao,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.favoriteDao, this.historyDao, Key key}) : super(key: key);
  final FavoriteDao favoriteDao;
  final HistoryDao historyDao;

  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: AppConstant.lightBG,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: AppConstant.fontSizeBody),
          headline2: TextStyle(
              fontSize: AppConstant.fontSizeBody2, fontWeight: FontWeight.bold),
          caption: TextStyle(
              fontSize: AppConstant.fontSizeCaption,
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: AppConstant.fontSizeDisplay,
              fontWeight: FontWeight.bold),
          headline5: TextStyle(
              fontSize: AppConstant.fontSizeDisplay,
              fontWeight: FontWeight.bold),
        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      initialRoute: AppConstant.pageSplash,
      getPages: [
        GetPage(name: AppConstant.pageSplash, page: () => SplashScreen(favoriteDao, historyDao), binding: SampleBind() 

        )
      ],
      routes: {
        AppConstant.pageSplash: (context) =>
            SplashScreen(favoriteDao, historyDao),
        AppConstant.pageIntro: (context) => IntroScreen(),
        AppConstant.pageHome: (context) => HomeScreen(
              favoriteDao: favoriteDao,
              historyDao: historyDao,
            ),
      },
    );
  }
}
class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueController>(() => ValueController());
    Get.lazyPut<DBController>(() => DBController(favoriteDao));
  }
}