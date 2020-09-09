import 'package:engtrhukuksozluk/data/db/dao/HistoryDao.dart';
import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/data/service/db_controller_service.dart';
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
import 'package:get/get.dart';

class SearchWords extends StatefulWidget {
  final FavoriteDao favoriteDao;
  const SearchWords({Key key, this.favoriteDao}) : super(key: key);

  @override
  _SearchWordsState createState() => _SearchWordsState();
}

class _SearchWordsState extends State<SearchWords> {
  TextEditingController _searchText = TextEditingController(text: "");
  FocusNode _searchNode = FocusNode();
  DataHelper _dataHelper = DataHelper();

  List<AlgoliaObjectSnapshot> _results = [];
  FavoriteDatabase favoriteDatabase;
  HistoryDatabase historyDatabase;
  History history;
  HistoryDao historyDao;
  bool isKeyboardVisible;
  bool _searching = false;
  SizeConfig sizeConfig = SizeConfig();
  final controllers = Get.put(DBController(favoriteDao));

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

    await controllers.insertHistoryWord(historyWordDb);

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
                                        onPressed: () {
                                          controllers.deleteHistory();
                                          setState(() {});
                                        })
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
                                          controllers.wordExists(
                                              patient, favId, context);
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
