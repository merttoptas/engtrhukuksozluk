import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:engtrhukuksozluk/widgets/frontFlipCard.dart';
import 'package:engtrhukuksozluk/widgets/backendFlipCard.dart';
import 'package:engtrhukuksozluk/widgets/textCard.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:engtrhukuksozluk/service/cloud_service.dart';
import 'package:engtrhukuksozluk/model/valueModel.dart';

class WordsLearn extends StatefulWidget {
  String string;
  @override
  _WordsLearnState createState() => _WordsLearnState();

}

typedef void StringCallback(int val);
class _WordsLearnState extends State<WordsLearn> {

  _WordsLearnState({this.callback,this.valueNotifier2, this.valueNotifier1});
  final StringCallback callback;

  List<Words> wordslist;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final ValueNotifier valueNotifier1;
  final ValueNotifier valueNotifier2;
  int value1 = 0;
  int value2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF2A2E43),
        title: Text('Kelime Öğrenme'),
        centerTitle: true,
      ),
      backgroundColor: Color(0XFF2A2E43),
    body: Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<Words>>(
            future: GetWordsCloud().getRandomWords(),
            builder: (context, wordsList){
              if(!wordsList.hasData){
                return FlipCard(key: cardKey,
                  back: backendFlipCard(cardKey: cardKey,text: "",),
                  front: frontFlipCard(cardKey: cardKey,text: "",),
                );
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
                      back: backendFlipCard(cardKey: cardKey, text: currentWords.turkish, onButton2Press: (){
                        setState(() {
                          model.value2++;
                          cardKey.currentState.toggleCard();
                        });

                      }, onButton3Press: (){
                        setState(() {
                          model.value1++;
                          cardKey.currentState.toggleCard();
                        });
                        },),
                      front: frontFlipCard(cardKey: cardKey, text: currentWords.english,),
                    );
                  },
                  itemCount:1,
                  shrinkWrap: true,
                );
              }
            },
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: textCard(
              valueNotifier1: model.onValue1Change,
              valueNotifier2: model.onValue2Change,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

