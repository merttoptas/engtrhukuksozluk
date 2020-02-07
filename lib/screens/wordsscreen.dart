import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/screens/aboutus.dart';
import 'package:engtrhukuksozluk/screens/WordsPage.dart';
import 'package:engtrhukuksozluk/screens/searchwords.dart';
import 'package:engtrhukuksozluk/screens/favoritewords.dart';

class WordsScreen extends StatefulWidget {
  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {

  int _currentIndex = 0;
  // ignore: missing_return
  Widget routerPage(int selectedIndex){
    switch(selectedIndex){
      case 0: return WordsPage();
      case 1: return FavoriteWords();
      case 2: return SearchWords();
      case 3: return AboutUs();

        break;
      default :return WordsScreen();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hukuk Sözlüğü', style: TextStyle(fontWeight: FontWeight.w600),),
        backgroundColor: Color(0XFF2A2E43),
      ),
      body: routerPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Kelimeler'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Favoriler'),
            activeIcon: Icon(Icons.favorite, color: Colors.red,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Arama')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Hakkımızda'),

          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color(0XFF2A2E43),
        onTap: (value){
          _currentIndex=value;
          setState(() {
          });
        },
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
