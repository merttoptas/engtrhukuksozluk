import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:engtrhukuksozluk/ui/screens/aboutus_page.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/screens/favorite_page.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/ui/screens/search_page.dart';
import 'package:engtrhukuksozluk/ui/screens/words_page.dart';

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
      
      bottomNavigationBar: CircleBottomNavigation(
        textColor: Colors.black,
        barHeight: 60,
        circleColor: Color(0XFF78aaff),
        inactiveIconColor: Colors.grey,
        circleSize: 42,
        arcHeight:30,
        circleOutline:10,
        hasElevationShadows: true,
        tabs: [
          TabData(
            icon: Icons.list,
            iconSize: 30,
            title: AppConstant.pageWords,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          TabData(
            icon: Icons.search,
            iconSize: 30,
            title: AppConstant.pageSearch,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          TabData(
            icon: Icons.favorite_border,
            iconSize: 30,
            title: AppConstant.pageFavorite,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          TabData(
            icon: Icons.account_circle,
            iconSize: 30,
            title: AppConstant.pageAbout,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
        initialSelection: selectIndexId,
        onTabChangedListener: (value){ selectIndexId=value;
        setState(() {
        }); },
      ),
    );
  }
}