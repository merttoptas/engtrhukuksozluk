import 'package:algolia/algolia.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/data/database/database.dart';
import 'package:engtrhukuksozluk/widgets/bottomSheetsWidgets.dart';

class SearchWords extends StatefulWidget {

  @override
  _SearchWordsState createState() => _SearchWordsState();
}

class _SearchWordsState extends State<SearchWords> {

  TextEditingController _searchText = TextEditingController(text: "");

  List<AlgoliaObjectSnapshot> _results = [];

  bool _searching = false;



  FocusNode _searchNode = FocusNode();

  Future _search(String searchText) async{
    setState(() {
      _searching = true;
    });

    Algolia algolia = Algolia.init(
        applicationId: AppConstant.applicationId,
        apiKey: AppConstant.apiKey,
    );

    AlgoliaQuery query = algolia.instance.index('words');

    if(_searchText.text !=null){
      query = query.search(_searchText.text);
      _results =(await query.getObjects()).hits;
      setState(() {
        _searching = false;
      });
    }
    else{
      setState(() {
        _searching = false;

      });
    }

    if(_searchText.text == ""){
      setState(() {
        _searching = false;

      });

    }



    return _results;
  }
  bool isLiked=false;

  FavoriteDatabase favoriteDatabase;
  FavoriteDao favoriteDao;

  List<Favorite> favoriteList = [];
  List<Favorite> favExistsList = [];
  builder() async{
    favoriteDatabase = await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchNode.addListener(_listener);
    builder();
  }

  void _listener(){
    if(_searchNode.hasFocus){
      setState(() {
        _searching = true;

      });
    }else{
      setState(() {
        _searching = false;
      });
    }
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

  Future insertWord(Favorite favorite) async {
    Scaffold.of(context).showSnackBar(SnackBar(content:
      const Text('Favorilerime Eklendi',),
      behavior: SnackBarBehavior.floating,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      duration: Duration(milliseconds: 1500),)
    );
    return await favoriteDao.insertFavoriteWord(favorite);

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
              Icons.arrow_back_ios, color: Color(0xFF0A151F),
            ),),
          elevation: 0,
          backgroundColor: Color(0xFFF8F8F8),
          title: Text(
            'Kelime Arama',
            style: TextStyle(color: Color(0xFF0A151F)),
          ),

    brightness: Brightness.light,
    ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0, right:16.0, top: 10.0,bottom: 5.0),
            child: TextField(onTap: (){
            },
              controller: _searchText,
              onChanged: _search,
              focusNode: _searchNode,
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
          Container(
            child: Expanded(
              flex: 1,
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
                  return  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16.0,bottom: 8,top: 8),
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black26,
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () async {
                          BottomSheetWidget().settingModalBottomSheet(context: context,
                              word: snap.data['turkish'],
                              title: snap.data['turkish'],
                              onTapVoice: (){print('voice');},
                              onTapFav: (bool isLiked) async {
                                String english = snap.data['english'];
                                String turkish = snap.data['turkish'];
                                int favId = snap.data['id'];
                                var patient = Favorite(turkish: turkish, english: english, favId: favId);

                                wordExists(patient, favId);
                                return !isLiked;

                              }
                            );

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start  ,
                                children: <Widget>[
                                  Text(
                                  snap.data['english'],
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppConstant.lightAccent,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
