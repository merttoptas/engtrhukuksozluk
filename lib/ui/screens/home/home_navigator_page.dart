import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/ui/screens/aboutus_page.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/screens/favorite_page.dart';
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';
import 'package:engtrhukuksozluk/ui/screens/search_page.dart';
import 'package:engtrhukuksozluk/ui/screens/words_page.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({Key key, this.selectIndexId}) : super(key: key);
  final int selectIndexId;

  @override
  _WordsScreenState createState() => _WordsScreenState(selectIndexId);
}

class _WordsScreenState extends State<WordsScreen> {
  int selectIndexId;
  int currentIndex = 0;
  FavoriteDao favoriteDao;
  _WordsScreenState(this.selectIndexId);

  Widget routerPage(int selectIndexId) {
    switch (selectIndexId) {
      case 0:
        return WordsPage();
      case 1:
        return SearchWords();
      case 2:
        return FavoriteWords();
      case 3:
        return AboutUs();

        break;
      default:
        return WordsScreen(
          selectIndexId: selectIndexId,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: routerPage(selectIndexId),
      bottomNavigationBar: CircleBottomNavigation(
        textColor: Colors.black,
        barHeight: AppConstant.barHeight,
        circleColor: AppConstant.circleColor,
        inactiveIconColor: Colors.grey,
        circleSize: AppConstant.circleSize,
        arcHeight: AppConstant.archHeight,
        circleOutline: AppConstant.circleOutline,
        hasElevationShadows: true,
        tabs: [
          TabData(
            icon: Icons.list,
            iconSize: AppConstant.tabIconSize,
            title: AppConstant.pageWords,
            fontSize: AppConstant.tabFontSize,
            fontWeight: FontWeight.bold,
          ),
          TabData(
            icon: Icons.search,
            iconSize: AppConstant.tabIconSize,
            title: AppConstant.pageSearch,
            fontSize: AppConstant.tabFontSize,
            fontWeight: FontWeight.bold,
          ),
          TabData(
            icon: Icons.favorite_border,
            iconSize: AppConstant.tabIconSize,
            title: AppConstant.pageFavorite,
            fontSize: AppConstant.tabFontSize,
            fontWeight: FontWeight.bold,
          ),
          TabData(
            icon: Icons.account_circle,
            iconSize: AppConstant.tabIconSize,
            title: AppConstant.pageAbout,
            fontSize: AppConstant.tabFontSize,
            fontWeight: FontWeight.bold,
          ),
        ],
        initialSelection: selectIndexId,
        onTabChangedListener: (value) {
          selectIndexId = value;
          setState(() {});
        },
      ),
    );
  }
}