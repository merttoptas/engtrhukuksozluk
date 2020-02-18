import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/wordsRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:engtrhukuksozluk/service/cloud_service.dart';
import 'package:provider/provider.dart';

class WordsPage extends StatefulWidget {
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  var isFavorite = false;
  final databaseReference = Firestore.instance;
  List<Words> wordslist;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Words>>(
        future: GetWordsCloud().getAllWords(),
        builder: (context, wordsList){
          if(!wordsList.hasData){
            return Center(
              child:CircularProgressIndicator(backgroundColor: Color(0XFF2A2E43),),);
          }
          else{
            var allWordsList= wordsList.data;
            return ListView.builder(
              itemBuilder: (context, index){
                var currentWords = allWordsList[index];
                return wordsRowWidget(text: currentWords.english,);
              },
              itemCount: allWordsList.length,
            );
          }
        },
      ),
    );
  }
}

