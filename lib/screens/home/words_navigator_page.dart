import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:engtrhukuksozluk/screens/aboutus_page.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/screens/favorite_page.dart';
import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/screens/search_page.dart';
import 'package:engtrhukuksozluk/screens/words_page.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({Key key,this.selectIndexId}): super(key: key);
  final int selectIndexId;

  @override
  _WordsScreenState createState() => _WordsScreenState(selectIndexId);
}

class _WordsScreenState extends State<WordsScreen> {
  int selectIndexId;
  int currentIndex  = 0;
  FavoriteDao favoriteDao;
  _WordsScreenState(this.selectIndexId);

  Widget routerPage(int selectIndexId){
    switch(selectIndexId){
      case 0: return WordsPage();
      case 1: return SearchWords();
      case 2: return FavoriteWords();
      case 3: return AboutUs();

      break;
      default :return WordsScreen(selectIndexId: selectIndexId,);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //routerPage(selectIndexId), 
      body: PageTransitionSwitcher(
          transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
          ){
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        child: routerPage(selectIndexId),

      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text(AppConstant.pageWords),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(AppConstant.pageSearch)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(AppConstant.pageFavorite),
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(AppConstant.pageAbout),
          ),
        ],
        currentIndex: selectIndexId,
        selectedItemColor: Color(0XFF2A2E43),
        onTap: (value){
          selectIndexId=value;
          setState(() {
          });
        },
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
