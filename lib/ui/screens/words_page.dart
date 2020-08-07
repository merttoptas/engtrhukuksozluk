import 'dart:async';

import 'package:engtrhukuksozluk/ui/widgets/adsWidget.dart';
import 'package:engtrhukuksozluk/ui/widgets/customAppBar.dart';
import 'package:engtrhukuksozluk/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';

import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/widgets/bottomSheetsWidgets.dart';
import 'package:engtrhukuksozluk/ui/widgets/wordsRow.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:engtrhukuksozluk/data/service/DataHelper.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_screenutil/screenutil.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({Key key}) : super(key: key);
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  Favorite favorite;
  FavoriteDao favoriteDao;
  QuerySnapshot cache;
  FavoriteDatabase favoriteDatabase;
  List<Favorite> favoriteList = [];
  List<Favorite> favExistsList = [];
  GetWordsCloud _getWordsCloud = GetWordsCloud();
  DataHelper _dataHelper = DataHelper();
  SizeConfig _sizeConfig = SizeConfig();
  List<Words> wordsList;
  double _height = 0;
  final _nativeAdController = NativeAdmobController();
  // ignore: cancel_subscriptions
  StreamSubscription subscription;

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

  Future wordExists(Favorite patient, int favId) async {
    await favoriteDao.getAllFavoriteWords().then((list) {
      favoriteList.addAll(list);
    });
    favoriteList.toList();

    await favoriteDao.getId(favId).then((list) {
      favExistsList.addAll(list);
    });

    if (favExistsList.toList().isNotEmpty) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppConstant.favSnackBarPositive),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      );
    } else {
      insertWord(patient);
    }
  }

  Future insertWord(Favorite favorite) async {
    await favoriteDao.insertFavoriteWord(favorite);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(AppConstant.favSnackBarPositive),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );
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
                              wordExists(patient, favId);
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
                        wordExists(patient, favId);
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
