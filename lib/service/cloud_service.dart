import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engtrhukuksozluk/model/Words.dart';
import 'package:provider/provider.dart';

final _firestore = Firestore.instance;
class GetWordsCloud{

  Future<List<Words>> getAllWords() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection('words').orderBy('english').getDocuments();
    List<Words> wordslist = [];

    for(DocumentSnapshot words in querySnapshot.documents){
      Words _wordslist = Words.fromMap(words.data);
      wordslist.add(_wordslist);
    }
    print('list' + wordslist.toString());
    return wordslist;

  }
  Future<List<Words>> getRandomWords() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection('words').orderBy('english').getDocuments();
    List<Words> wordslist = [];
    List<Words> randomList = [];
    for(DocumentSnapshot words in querySnapshot.documents) {
      Words _wordslist = Words.fromMap(words.data);
      wordslist.add(_wordslist);
    }

    var wordsListSize = wordslist.length;
    for(int i =0; i<wordsListSize; i++){
      var randomWords = wordslist[Random().nextInt(wordsListSize)];
      if(!randomList.contains(randomWords)){
        randomList.add(randomWords);
        String text = randomWords.english;
      }
    }
    print('deneme' + randomList.toString());
      return randomList;

    }
}

