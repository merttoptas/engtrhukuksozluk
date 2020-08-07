import 'package:engtrhukuksozluk/data/db/dao/HistoryDao.dart';
import 'package:engtrhukuksozluk/data/service/search_service.dart';
import 'package:engtrhukuksozluk/model/History.dart';
import 'package:engtrhukuksozluk/ui/widgets/customSearchAppBar.dart';
import 'package:engtrhukuksozluk/ui/widgets/historyWidget.dart';
import 'package:engtrhukuksozluk/utils/fade_animation.dart';
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
  const SearchWords({Key key}) : super(key: key);

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
  List<History> historyList = [];

  FavoriteDatabase favoriteDatabase;
  FavoriteDao favoriteDao;
  HistoryDatabase historyDatabase;
  History history;
  HistoryDao historyDao;
  bool isKeyboardVisible;
  bool _searching = false;
  SizeConfig sizeConfig = SizeConfig();

  Future _search() async {
    setState(() {
      _searching = true;
    });

    var algolia = SearchService().algolia();

    AlgoliaQuery query = algolia.instance.index('words');
    query = query.search(_searchText.text);
    query.setMinWordSizeFor1Typo(1);
    _results = (await query.getObjects()).hits;

    setState(() {
      _searching = false;
    });

    var historyWordDb = History(historyWord: _searchText.text.toString());

    await insertHistoryWord(historyWordDb);

    return _results;
  }

  _builder() async {
    favoriteDatabase =
        await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();

    historyDatabase =
        await $FloorHistoryDatabase.databaseBuilder('history.db').build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
      historyDao = historyDatabase.historyDao;
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

  void _listener() {
    if (_searchNode.hasFocus) {
      setState(() {
        _searching = true;
      });
    } else {
      setState(() {
        _searching = false;
      });
    }
  }

  Future _deleteHistory() async {
    await historyDao.deleteHistoryWord();
    setState(() {});
  }

  Future _wordExists(Favorite patient, int favId) async {
    await favoriteDao.getAllFavoriteWords().then((list) {
      favoriteList.addAll(list);
    });
    favoriteList.toList();

    await favoriteDao.getId(favId).then((list) {
      favExistsList.addAll(list);
    });

    if (favExistsList.toList().isNotEmpty) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppConstant.favSnackBarNegative),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      );
    } else {
      _insertWord(patient);
    }
  }

  Future _insertWord(Favorite favorite) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(AppConstant.favSnackBarPositive),
      behavior: SnackBarBehavior.floating,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      duration: Duration(milliseconds: 1500),
    ));
    return await favoriteDao.insertFavoriteWord(favorite);
  }

  Future insertHistoryWord(History history) async {
    return await historyDao.insertHistoryWord(history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSearchAppBar(
        controller: _searchText,
        focusNode: _searchNode,
        searching: _searching,
        function: () {
          _searching = !_searching;
          _searchText.text = "";
          setState(() {
            _results.clear();
          });
        },
        btnFunction: _search,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Expanded(
              flex: 1,
              child: _searching == true
                  ? Center(
                      child: FadeAnimatedTextKit(
                        text: [AppConstant.hintSearching],
                        textStyle: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : _results.length == 0
                      ? Center(
                          child: FadeAnimation(
                            delay: 0.3,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    HistoryBodyList(
                                      history: history,
                                      historyDao: historyDao,
                                      onPressed: _deleteHistory,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            AlgoliaObjectSnapshot snap = _results[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16.0, bottom: 8, top: 8),
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
                                        adsHeight:
                                            sizeConfig.heightSize(context, 11),
                                        word: snap.data['turkish'],
                                        title: snap.data['english'],
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        onTapVoice: () => _dataHelper
                                            .speak(snap.data['english']),
                                        onTapFav: (bool isLiked) async {
                                          String english = snap.data['english'];
                                          String turkish = snap.data['turkish'];
                                          int favId = snap.data['id'];
                                          var patient = Favorite(
                                              turkish: turkish,
                                              english: english,
                                              favId: favId);

                                          _wordExists(patient, favId);
                                          return !isLiked;
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snap.data['english'],
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              snap.data['turkish'],
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w500),
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
