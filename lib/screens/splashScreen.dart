import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  final  FavoriteDao favoriteDao;
  SplashScreen(this.favoriteDao);

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
            (status) {
          if (status) {
            _navigateToHome();
          } else {
            _navigateToHome();
          }
        }
    );
  }

 FavoriteDao favoriteDao;
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(favoriteDao)
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2A2E43),
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              Shimmer.fromColors(
                period: Duration(milliseconds: 2500),
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Hukuk Sözlüğü",
                      style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 40.0,
                          shadows: <Shadow>[
                            Shadow(
                                blurRadius: 18.0,
                                color: Colors.black87,
                                offset: Offset.fromDirection(120, 12)
                            )
                          ]
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}