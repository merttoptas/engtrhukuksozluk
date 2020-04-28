import 'package:engtrhukuksozluk/data/service/search_service.dart';
import 'package:engtrhukuksozluk/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:algolia/algolia.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:engtrhukuksozluk/ui/widgets/bottomSheetsWidgets.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/data/service/DataHelper.dart';


class SearchWords extends StatefulWidget {
 const SearchWords({Key key}): super(key: key);

  @override
  _SearchWordsState createState() => _SearchWordsState();
}

class _SearchWordsState extends State<SearchWords> {

  TextEditingController _searchText = TextEditingController(text: "");
  FocusNode _searchNode = FocusNode();
  DataHelper _dataHelper = DataHelper();


  List<AlgoliaObjectSnapshot> _results = [];
  List<Favorite> favoriteList = [];
  List<Favorite> favExistsList = [];

  FavoriteDatabase favoriteDatabase;
  FavoriteDao favoriteDao;
  bool isKeyboardVisible;
  bool _searching = false;
  SizeConfig  sizeConfig = SizeConfig();


  Future _search() async{
    setState(() {
      _searching = true;
    });

   var algolia = SearchService().algolia();

    AlgoliaQuery query = algolia.instance.index('words');
    query = query.search(_searchText.text);
    query.setMinWordSizeFor1Typo(1);
    _results =(await query.getObjects()).hits;

    setState(() {
      _searching = false;

    });


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
              Icons.arrow_back_ios, color: Colors.white,
            ),),
          elevation: 0.5,
          backgroundColor: AppConstant.lightPrimary,
          centerTitle: true,
          //backgroundColor: Color(0xFFF8F8F8),
          title: Text(
            AppConstant.hintSearch,
            style: TextStyle(color: Colors.white),
          ),
          brightness: Brightness.light,
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0,bottom: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all( color:Color(0XFF78aaff)),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              controller: _searchText,
                              focusNode: _searchNode,
                              decoration: InputDecoration(
                                hintText: 'Arama',
                                hintStyle: TextStyle(fontSize: 14, color: AppConstant.darkBG),
                                //
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Container(
                                  margin: EdgeInsets.only(bottom: 0),
                                  child: Icon(
                                    Icons.search,
                                    color: AppConstant.darkBG,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 0,
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 0,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: AppConstant.darkBG,
                              size: 20,
                            ),
                            onPressed: () {
                              _searching = !_searching;
                              _searchText.text = "";
                              setState(() {
                                _results.clear();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
               Padding(
                 padding: EdgeInsets.only(right: 16.0),
                 child: ButtonTheme(
                   height: 40,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                   child: RaisedButton(
                     onPressed: _search,
                     color: Color(0XFF78aaff),
                     child: Text('Ara', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1.3),),
                   ),
                 ),
               )
              ],
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
                            BottomSheetWidget().settingModalBottomSheet(
                                context: context,
                                adsHeight:sizeConfig.heightSize(context, 11) ,
                                word: snap.data['turkish'],
                                title: snap.data['english'],
                                onPressed: (){Navigator.pop(context);},
                                onTapVoice: () => _dataHelper.speak(snap.data['english']),
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
                                  color: Colors.black,
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

