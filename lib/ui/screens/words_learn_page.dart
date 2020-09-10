import 'dart:async';

import 'package:engtrhukuksozluk/ui/widgets/ads_widget.dart';
import 'package:engtrhukuksozluk/ui/widgets/custom_app_bar.dart';
import 'package:engtrhukuksozluk/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/widgets/backend_flip_card.dart';
import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/ui/widgets/front_flip_card.dart';
import 'package:engtrhukuksozluk/data/service/value_controller.dart';
import 'package:engtrhukuksozluk/ui/widgets/text_card.dart';
import 'package:engtrhukuksozluk/model/words.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';

class WordsLearn extends StatefulWidget {
  const WordsLearn({Key key}) : super(key: key);
  @override
  _WordsLearnState createState() => _WordsLearnState();
}

typedef void StringCallback(int val);

class _WordsLearnState extends State<WordsLearn> {
  _WordsLearnState({this.callback});
  final StringCallback callback;
  var size;
  String string;
  List<Words> wordsList;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  SizeConfig _sizeConfig = SizeConfig();
  double _height = 0;
  bool isCompleted = false;
  final _nativeAdController = NativeAdmobController();
  // ignore: cancel_subscriptions
  StreamSubscription subscription;
  final controller = Get.put(ValueController());
  final ValueController ctrl = Get.find();

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
          isCompleted = false;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = _sizeConfig.heightSize(context, 20);
          isCompleted = true;
        });
        break;

      case AdLoadState.loadError:
        setState(() {
          _height = 0;
          isCompleted = false;
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    ctrl.countLearn = 0.obs;
    ctrl.countNotLearn = 0.obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppConstant.wordLearnTitle,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<List<Words>>(
            future: GetWordsCloud()?.getRandomWords(),
            builder: (context, wordsList) {
              if (!wordsList.hasData) {
                return FlipCard(
                  key: cardKey,
                  back: BackendFlipCard(
                    cardKey: cardKey,
                    text: "",
                  ),
                  front: FrontFlipCard(
                    cardKey: cardKey,
                    text: "",
                  ),
                );
              } else {
                var allWordsList = wordsList.data;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var currentWords = allWordsList[index];
                      if (!wordsList.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppConstant.darkAccent,
                          ),
                        );
                      }
                      return buildFlipCard(currentWords);
                    },
                    itemCount: 1,
                    shrinkWrap: true,
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                left: AppConstant.cardPaddingLeftRight,
                right: AppConstant.cardPaddingLeftRight),
            child: TextCard(),
          ),
          Spacer(),
          buildNativeBanner(),
        ],
      ),
    );
  }

  FlipCard buildFlipCard(Words currentWords) {
    return FlipCard(
      key: cardKey,
      flipOnTouch: true,
      back: BackendFlipCard(
        cardKey: cardKey,
        text: currentWords.turkish,
        onButton2Press: () {
          setState(() {
            controller.incrementNotLearn();
            cardKey.currentState.toggleCard();
          });
        },
        onButton3Press: () {
          setState(() {
            controller.incrementLearn();
            cardKey.currentState.toggleCard();
          });
        },
      ),
      front: FrontFlipCard(
        cardKey: cardKey,
        text: currentWords.english,
      ),
    );
  }

  Padding buildNativeBanner() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstant.cardPaddingLeftRight,
          right: AppConstant.cardPaddingLeftRight,
          bottom: AppConstant.cardPaddingLeftRight),
      child: AdsWidget(
        admobController: _nativeAdController,
        borderRadius: BorderRadius.circular(12),
        height: _height,
        type: NativeAdmobType.banner,
      ),
    );
  }
}
