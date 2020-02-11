import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/wordsRow.dart';
import 'package:like_button/like_button.dart';


class FavoriteWords extends StatelessWidget {

  List<String> favoriteList =['favorite', 'favorite2'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (BuildContext context, int index){
                    return wordsRowWidget(wordList: favoriteList,text: index,);
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}
