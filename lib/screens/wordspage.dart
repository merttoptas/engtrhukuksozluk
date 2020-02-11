import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/wordsRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WordsPage extends StatefulWidget {
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  bool _alreadySaved;

  var isFavorite = false;

  List<String> wordList =['example', 'example2', 'example3', 'example4'];

  final databaseReference = Firestore.instance;

  final _firestore = Firestore.instance;

  void messagesStream() async{
    await for(var snapshot in _firestore.collection('words').orderBy('english').snapshots() ){
      for(var message in snapshot.documents){
        print(message.data);
        wordList.add(message.data.toString());

        }
    }
  }
  @override
  void initState() {
    super.initState();
    messagesStream();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  itemCount: wordList.length,
                  itemBuilder: (BuildContext context, int index){
                    return wordsRowWidget(wordList: wordList,text: index,);
                    },
                ),
            )
          ],
        ),
      ),
    );
  }
}


