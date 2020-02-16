import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:engtrhukuksozluk/widgets/frontFlipCard.dart';
import 'package:engtrhukuksozluk/widgets/backendFlipCard.dart';
import 'package:engtrhukuksozluk/widgets/textCard.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/service/cloud_service.dart';
import 'dart:math';

class WordsLearn extends StatefulWidget {

  @override
  _WordsLearnState createState() => _WordsLearnState();
}

class _WordsLearnState extends State<WordsLearn> {
  final _firestore = Firestore.instance;

  List<Words> wordslist;
  String randomTurkish;

  void messagesStream() async{
    await for(var snapshot in _firestore.collection('words').orderBy('english').snapshots() ){
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }
  void getData() async{
    await for(var snapshot in _firestore.collection('words').orderBy('english').snapshots() ){
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  int learnWords  =0;
  int notLearnWords =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF2A2E43),
        title: Text('Kelime Öğrenme'),
        centerTitle: true,
      ),
      backgroundColor: Color(0XFF2A2E43),
    body: Column(
      children: <Widget>[
         FutureBuilder<List<Words>>(
          future: GetWordsCloud().getRandomWords(),
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
                  if(!wordsList.hasData){
                    return Center(
                      child:CircularProgressIndicator(backgroundColor: Color(0XFF2A2E43),),);
                  }
                  return FlipCard(
                    key: cardKey,

                    flipOnTouch: true,
                    onFlip: (){
                      String newText = currentWords.turkish;
                      print(newText);

                    },
                    back: backendFlipCard(cardKey: cardKey, text: currentWords.turkish,),
                    front: frontFlipCard(cardKey: cardKey, text: currentWords.english,),
                  );
                },
                itemCount:1,
                shrinkWrap: true,

              );
            }
          },
        ),

        Padding(
          padding: const EdgeInsets.only(top:10.0, left: 20.0,right: 20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 80,
                width: 350.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        textCard(text: 'Öğrenilen', number: learnWords.toString(),),
                        textCard(text: 'Bilinmeyen', number: notLearnWords.toString(),),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}

