import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/screens/homeScreen.dart';
import 'package:engtrhukuksozluk/utils/const.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAnalytics analytics = FirebaseAnalytics();

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: isDark ? Constants.darkTheme: Constants.lightTheme,
      home:  HomeScreen(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}



