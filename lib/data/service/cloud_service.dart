import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/model/favorite.dart';
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';
import 'package:engtrhukuksozluk/model/words.dart';

final _firestore = Firestore.instance;
FavoriteDao favoriteDao;
Favorite favorite;

class GetWordsCloud {
  List<Favorite> favoriteList = [];
  List<Favorite> favExistsList = [];

  Future<List<Words>> getAllWords() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('words').orderBy('english').getDocuments();
    List<Words> wordsList = [];

    for (DocumentSnapshot words in querySnapshot.documents) {
      Words _wordsList = Words.fromMap(words.data);
      wordsList.add(_wordsList);
    }
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot doc = querySnapshot.documents.elementAt(i);
      print(doc.metadata.isFromCache ? "not from network" : "from network");
    }
    return wordsList;
  }

  Future<List<Words>> getRandomWords() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('words').orderBy('english').getDocuments();
    List<Words> wordsList = [];
    List<Words> randomList = [];

    for (DocumentSnapshot words in querySnapshot.documents) {
      Words _wordsList = Words.fromMap(words.data);
      wordsList.add(_wordsList);
    }

    var wordsListSize = wordsList.length;
    for (int i = 0; i < wordsListSize; i++) {
      var randomWords = wordsList[Random().nextInt(wordsListSize)];
      if (!randomList.contains(randomWords)) {
        randomList.add(randomWords);
      }
    }
    return randomList;
  }
}
