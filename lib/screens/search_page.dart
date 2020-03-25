import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:algolia/algolia.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:engtrhukuksozluk/widgets/bottomSheetsWidgets.dart';
import 'package:engtrhukuksozluk/data/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/data/database/database.dart';

class SearchWords extends StatefulWidget {
 const SearchWords({Key key}): super(key: key);

  @override
  _SearchWordsState createState() => _SearchWordsState();
}

class _SearchWordsState extends State<SearchWords> {

  TextEditingController _searchText = TextEditingController(text: "");
  FocusNode _searchNode = FocusNode();

  List<AlgoliaObjectSnapshot> _results = [];
  List<Favorite> favoriteList = [];
  List<Favorite> favExistsList = [];

  FavoriteDatabase favoriteDatabase;
  FavoriteDao favoriteDao;

  bool _searching = false;

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
  _builder() async{
    favoriteDatabase = await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchNode.addListener(_listener);
    _builder();
  }
  @override
  void dispose() {
    super.dispose();
    _searchNode.addListener(_listener);
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
  Future _wordExists(Favorite patient, int favId )async{

    await favoriteDao.getAllFavoriteWords().then((list){favoriteList.addAll(list);});
    favoriteList.toList();

    await favoriteDao.getId(favId).then((list){favExistsList.addAll(list);});

    if(favExistsList.toList().isNotEmpty){
      Scaffold.of(context).showSnackBar(SnackBar(content:
       Text(AppConstant.favSnackBarNegative),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
      );
    }else{
      _insertWord(patient);
    }

  }

  Future _insertWord(Favorite favorite) async {
    Scaffold.of(context).showSnackBar(SnackBar(content:
       Text(AppConstant.favSnackBarPositive),
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
            AppConstant.hintSearch,
            style: TextStyle(color: Color(0xFF0A151F)),
          ),
    brightness: Brightness.light,
    ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0, right:16.0, top: 10.0,bottom: 5.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all( color:Color(0XFF2A2E43)),
                  boxShadow:[
                    BoxShadow(color: Colors.white.withOpacity(0.1), offset: Offset(0, 0), blurRadius: 3, spreadRadius: 1)
                  ]
              ),
              child: TextField(onTap: (){
              },
                controller: _searchText,
                onChanged: _search,
                focusNode: _searchNode,
                decoration: InputDecoration(
                  hintText: AppConstant.hintSearch,
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
          ),
          Container(
            child: Expanded(
              flex: 1,
              child: _searching == true
                  ? Center(
                child: FadeAnimatedTextKit(
                  text: [AppConstant.hintSearching],
                  textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
              )
                  : _results.length ==0
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(AppConstant.svgBoard,height: 250,width: 250,),
                    SizedBox(height: 10.0,),
                    Text(AppConstant.defaultSearch, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)
                  ],
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

                                _wordExists(patient, favId);
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
