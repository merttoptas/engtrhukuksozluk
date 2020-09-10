import 'dart:async';

import 'package:engtrhukuksozluk/data/service/db_controller_service.dart';
import 'package:engtrhukuksozluk/ui/widgets/ads_widget.dart';
import 'package:engtrhukuksozluk/ui/widgets/custom_app_bar.dart';
import 'package:engtrhukuksozluk/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/model/favorite.dart';
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/widgets/bottom_sheets.dart';
import 'package:engtrhukuksozluk/ui/widgets/words_row.dart';
import 'package:engtrhukuksozluk/model/words.dart';
import 'package:engtrhukuksozluk/data/service/text_to_speech_helper.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';

class WordsPage extends StatefulWidget {
  final FavoriteDao favoriteDao;
  const WordsPage({Key key, this.favoriteDao}) : super(key: key);
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  Favorite favorite;
  QuerySnapshot cache;
  FavoriteDatabase favoriteDatabase;
  GetWordsCloud _getWordsCloud = GetWordsCloud();
  DataHelper _dataHelper = DataHelper();
  SizeConfig _sizeConfig = SizeConfig();
  double _height = 0;
  final _nativeAdController = NativeAdmobController();
  // ignore: cancel_subscriptions
  StreamSubscription subscription;
  final controllers = Get.put(DBController(favoriteDao));

  @override
  void initState() {
    super.initState();
    subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    _getWordsCloud.getAllWords();
    _builder();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = ScreenUtil().setHeight(100);
        });
        break;

      default:
        break;
    }
  }

  _builder() async {
    favoriteDatabase =
        await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppConstant.wordsPage,
      ),
      body: buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FutureBuilder<List<Words>>(
            future: _getWordsCloud.getAllWords(),
            builder: (context, wordsList) {
              if (!wordsList.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0XFF2A2E43),
                  ),
                );
              } else {
                var allWordsList = wordsList.data;
                return ListView.separated(
                  itemCount: allWordsList.length,
                  separatorBuilder: (context, int index) {
                    if (index % 20 == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: AdsWidget(
                          height: _height,
                          borderRadius: BorderRadius.circular(15),
                          type: NativeAdmobType.banner,
                          admobController: _nativeAdController,
                        ),
                      );
                    }
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  },
                  itemBuilder: (context, index) {
                    var currentWords = allWordsList[index];
                    return WordsRowWidget(
                      onTap: () async {
                        BottomSheetWidget().settingModalBottomSheet(
                            context: context,
                            word: currentWords.turkish,
                            title: currentWords.english,
                            adsHeight: _sizeConfig.heightSize(context, 11),
                            onTapVoice: () =>
                                _dataHelper.speak(currentWords.english),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            onTapFav: (bool isLiked) async {
                              String english = currentWords.english;
                              String turkish = currentWords.turkish;
                              int favId = currentWords.id;
                              var patient = Favorite(
                                  turkish: turkish,
                                  english: english,
                                  favId: favId);
                              controllers.wordExists(patient, favId, context);
                              return !isLiked;
                            });
                      },
                      text: currentWords.english,
                      onButtonPress: (bool isLiked) async {
                        String english = currentWords.english;
                        String turkish = currentWords.turkish;
                        int favId = currentWords.id;

                        var patient = Favorite(
                            turkish: turkish, english: english, favId: favId);
                        controllers.wordExists(patient, favId, context);
                        return !isLiked;
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
