import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/screens/aboutus.dart';
import 'package:engtrhukuksozluk/screens/wordsPage.dart';
import 'package:engtrhukuksozluk/screens/searchWords.dart';
import 'package:engtrhukuksozluk/screens/favoriteWords.dart';

class WordsScreen extends StatefulWidget {
  final int selectIndexId;
  WordsScreen(this.selectIndexId);



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
      default :return WordsScreen(selectIndexId);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hukuk Sözlüğü',
          style: TextStyle(
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0XFF2A2E43),
      ),
      body: routerPage(selectIndexId),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Kelimeler'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Arama')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Favoriler'),
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Hakkımızda'),

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
