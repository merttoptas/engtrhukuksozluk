import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/utils/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class SearchWords extends StatefulWidget {

  @override
  _SearchWordsState createState() => _SearchWordsState();
}

class _SearchWordsState extends State<SearchWords> {
  TextEditingController _searchText = TextEditingController(text: "");

  List<AlgoliaObjectSnapshot> _results = [];

  bool _searching = false;

  Future _search(String searchText) async{
    setState(() {
      _searching = true;
    });

    Algolia algolia = Algolia.init(
        applicationId: Constants.applicationId,
        apiKey: Constants.apiKey,
    );

    AlgoliaQuery query = algolia.instance.index('words');
    query = query.search(_searchText.text);

    _results =(await query.getObjects()).hits;
    setState(() {
      _searching = false;
    });

    return _results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(onTap: (){
              },
                controller: _searchText,
                onChanged: _search,
                decoration: InputDecoration(
                  hintText: 'Arama',
                  hoverColor: Color(0xff5563ff),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF2A2E43)),
                  ),
                  prefixIcon: Icon(Icons.search,color: Color(0XFF2A2E43),),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searching == true
                  ? Center(
                child: FadeAnimatedTextKit(
                  text: ['Aranıyor bekleyin..'],
                  textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
              )
                  : _results.length ==0
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/board.png',),
                      SizedBox(height: 10.0,),
                      Text('Henüz arama yapılmadı..', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),)
                    ],
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _results.length,
                itemBuilder: (BuildContext ctx, int index){
                  AlgoliaObjectSnapshot snap = _results[index];
                  return ListTile(
                    contentPadding:EdgeInsets.only(left: 6.0,right: 6.0),
                    title:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            elevation: 2.0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0, left: 10.0, bottom: 3.0),
                                        child: Text(snap.data['english'], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3.0,),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                                        child: Text(snap.data['turkish'], style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
