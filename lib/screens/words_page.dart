import 'package:engtrhukuksozluk/data/database/database.dart';
import 'package:engtrhukuksozluk/widgets/bottomSheetsWidgets.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/wordsRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:engtrhukuksozluk/service/cloud_service.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';

class WordsPage extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    GetWordsCloud().getAllWords();
    builder();
  }

  builder() async{
    favoriteDatabase = await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
  }

  Future wordExists(Favorite patient, int favId )async{

    await favoriteDao.getAllFavoriteWords().then((list){favoriteList.addAll(list);});
    favoriteList.toList();

    await favoriteDao.getId(favId).then((list){favExistsList.addAll(list);});

    if(favExistsList.toList().isNotEmpty){
      Scaffold.of(context).showSnackBar(SnackBar(content:
      const Text('Favorilerimde Zaten Var'),
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
    const Text('Favorilerime Eklendi',),
      behavior: SnackBarBehavior.floating,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      duration: Duration(milliseconds: 1500),)
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
            color: Color(0xFF0A151F),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFF8F8F8),
        title: Text(
          'Hukuk Kelimeleri',
          style: TextStyle(color: Color(0xFF0A151F)),
        ),

        brightness: Brightness.light,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder<List<Words>>(
              future: GetWordsCloud().getAllWords(),
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
                      return wordsRowWidget(
                        onTap: ()async{
                          BottomSheetWidget().settingModalBottomSheet(context: context,
                              word: currentWords.turkish,
                              title: currentWords.english,
                              onTapVoice: (){print('voice');},
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

