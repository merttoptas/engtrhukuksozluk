import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/wordsRow.dart';
import 'package:like_button/like_button.dart';


class FavoriteWords extends StatelessWidget {

  List<String> favoriteList = ['deneme,','deneme2'];
  String text = 'deneme';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Text('deneme'),
                  ],
                 ),
              ),
            ],
          ),
      ),
    );
  }
}
