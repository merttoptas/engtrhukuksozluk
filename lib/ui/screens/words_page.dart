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
import 'package:engtrhukuksozluk/data/service/data.dart';
import 'package:provider/provider.dart';



class WordsPage extends StatefulWidget {
  const WordsPage({Key key}): super(key:key);
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



  @override
  void initState() {
    super.initState();
    _getWordsCloud.getAllWords();
    _builder();
  }

  _builder() async{
    favoriteDatabase = await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
  }


  Future wordExists(Favorite patient, int favId ) async{

    await favoriteDao.getAllFavoriteWords().then((list){favoriteList.addAll(list);});
    favoriteList.toList();

    await favoriteDao.getId(favId).then((list){favExistsList.addAll(list);});

    if(favExistsList.toList().isNotEmpty){
      Scaffold.of(context).showSnackBar(SnackBar(content:
      Text(AppConstant.favSnackBarPositive),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
      );
    }else{
      insertWord(patient);
    }

  }
  Future insertWord(Favorite favorite)async{
    await favoriteDao.insertFavoriteWord(favorite);
    Scaffold.of(context).showSnackBar(SnackBar(content:
      Text(AppConstant.favSnackBarPositive),
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
      appBar:  AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        elevation: 0.5,
        brightness: Brightness.light,
        backgroundColor: Color(0XFF78aaff),
        centerTitle: true,
        title: Text(
          AppConstant.wordsPage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder<List<Words>>(
              future:_getWordsCloud.getAllWords() ,
              builder: (context, wordsList){
                if(!wordsList.hasData){
                  return Center(
                    child:CircularProgressIndicator(
                      backgroundColor: Color(0XFF2A2E43),
                    ),
                  );
                }
                else{
                  var allWordsList= wordsList.data;
                  return ListView.builder(
                    itemBuilder: (context, index){
                      var currentWords = allWordsList[index];
                      return WordsRowWidget(
                        onTap: ()async{
                          BottomSheetWidget().settingModalBottomSheet(context: context,
                              word: currentWords.turkish,
                              title: currentWords.english,
                              onTapVoice: () => _dataHelper.speak(currentWords.english),
                              onPressed: (){Navigator.pop(context);},
                              onTapFav: (bool isLiked) async {

                                String english = currentWords.english;
                                String turkish =currentWords.turkish;
                                int favId = currentWords.id;

                                var patient = Favorite(turkish: turkish, english: english, favId: favId);
                                wordExists(patient, favId);
                                  return !isLiked;

                              }
                          );
                        },
                        text: currentWords.english,
                        onButtonPress: (bool isLiked) async{
                          String english = currentWords.english;
                          String turkish = currentWords.turkish;
                          int favId = currentWords.id;

                          var patient = Favorite(turkish: turkish, english: english, favId: favId);
                          wordExists(patient, favId);
                          return !isLiked;
                        },
                      );
                    },
                    itemCount: allWordsList.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}
