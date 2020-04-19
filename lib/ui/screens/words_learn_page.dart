import 'package:engtrhukuksozluk/ui/widgets/adsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/widgets/backendFlipCard.dart';
import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/ui/widgets/frontFlipCard.dart';
import 'package:engtrhukuksozluk/model/valueModel.dart';
import 'package:engtrhukuksozluk/ui/widgets/textCard.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

class WordsLearn extends StatefulWidget {
  const WordsLearn({Key key}):super(key:key);
  @override
  _WordsLearnState createState() => _WordsLearnState();

}

typedef void StringCallback(int val);
class _WordsLearnState extends State<WordsLearn> {
  _WordsLearnState({this.callback,this.valueNotifier2, this.valueNotifier1});
  final StringCallback callback;
  final ValueNotifier valueNotifier1;
  final ValueNotifier valueNotifier2;
  var size;
  int value1 = 0;
  int value2 = 0;
  String string;
  List<Words> wordsList;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  
@override
  void initState() {
  setState(() {
     model.value1 = 0;
     model.value2 = 0;
    });

  super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios, color: Colors.white,
          ),),
        elevation: 0,
        backgroundColor: Color(0XFF78aaff),
        title: Text(
          AppConstant.hintSearch,
          style: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.light,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                FutureBuilder<List<Words>>(
                  future: GetWordsCloud().getRandomWords(),
                  builder: (context, wordsList){
                    if(!wordsList.hasData){
                      return FlipCard(
                        key: cardKey,
                        back: BackendFlipCard(cardKey: cardKey,text: "",),
                        front: FrontFlipCard(cardKey: cardKey,text: "",),
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
                            back: BackendFlipCard(cardKey: cardKey, text: currentWords.turkish, onButton2Press: (){
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
                            front: FrontFlipCard(cardKey: cardKey, text: currentWords.english,),
                          );
                        },
                        itemCount:1,
                        shrinkWrap: true,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: TextCard(
                    valueNotifier1: model.onValue1Change,
                    valueNotifier2: model.onValue2Change,
                  ),
                ),
                SizedBox(height: 30,),
                  Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AdsWidget(borderRadius: BorderRadius.circular(12), height: 200.0,type: NativeAdmobType.full,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

