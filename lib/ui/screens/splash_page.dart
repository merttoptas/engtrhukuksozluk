import 'dart:async';
import 'package:engtrhukuksozluk/data/db/dao/HistoryDao.dart';
import 'package:flutter/material.dart';

import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  final FavoriteDao favoriteDao;
  final HistoryDao historyDao;
  SplashScreen(this.favoriteDao, this.historyDao);
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToHome();
      }
    });
  }

  FavoriteDao favoriteDao;

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});

    return true;
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, AppConstant.pageIntro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.lightBG,
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppConstant.svgAppIcon,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200.0,
                  width: 200,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
