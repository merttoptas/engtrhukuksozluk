
import 'package:engtrhukuksozluk/data/database/database.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/wordsRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:engtrhukuksozluk/service/cloud_service.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

  Future insertWord(Favorite favorite)async{

    await favoriteDao.insertFavoriteWord(favorite);
    Scaffold.of(context).showSnackBar(SnackBar(content:
    const Text('Favorilerime Eklendi'),
      duration: Duration(milliseconds: 1500),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Words>>(
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
            return AnimationLimiter(
              child: ListView.builder(
                itemBuilder: (context, index){
                  var currentWords = allWordsList[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: wordsRowWidget(
                        text: currentWords.english,
                        onButtonPress: (bool isLiked) async{
                          String english = currentWords.english;
                          String turkish = currentWords.turkish;
                          int favId = currentWords.id;

                          var patient = Favorite(turkish: turkish, english: english, favId: favId);

                          await favoriteDao.getAllFavoriteWords().then((list){favoriteList.addAll(list);});
                          favoriteList.toList();

                          await favoriteDao.getId(favId).then((list){favExistsList.addAll(list);});

                          if(favExistsList.toList().isNotEmpty){
                             Scaffold.of(context).showSnackBar(SnackBar(content:
                             const Text('Favorilerimde Zaten Var'),
                               duration: Duration(milliseconds: 1500),)
                             );
                           }else{
                             insertWord(patient);
                           }

                          return !isLiked;
                        },
                      ),
                    ),
                  );
                },
                itemCount: allWordsList.length,
              ),
            );
          }
        },
      ),
    );
  }
}