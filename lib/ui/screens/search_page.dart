import 'package:engtrhukuksozluk/data/db/dao/historyDao.dart';
import 'package:engtrhukuksozluk/data/service/cloud_service.dart';
import 'package:engtrhukuksozluk/data/service/db_controller_service.dart';
import 'package:engtrhukuksozluk/data/service/search_service.dart';
import 'package:engtrhukuksozluk/model/history.dart';
import 'package:engtrhukuksozluk/ui/widgets/custom_search_app_bar.dart';
import 'package:engtrhukuksozluk/ui/widgets/history_widget.dart';
import 'package:engtrhukuksozluk/utils/fade_animation.dart';
import 'package:engtrhukuksozluk/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:algolia/algolia.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/model/favorite.dart';
import 'package:engtrhukuksozluk/ui/widgets/bottom_sheets.dart';
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/data/service/text_to_speech_helper.dart';
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
      body: buildBody(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Expanded(
            flex: 1,
            child: _searching == true
                ? Center(
                    child: FadeAnimatedTextKit(
                      text: [AppConstant.hintSearching],
                      textStyle: TextStyle(
                          fontSize: AppConstant.fontSizeBody2,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  )
                : _results.length == 0 ? buildCenter() : buildListView(context),
          ),
        )
      ],
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (BuildContext ctx, int index) {
        AlgoliaObjectSnapshot snap = _results[index];
        return Padding(
          padding: EdgeInsets.only(
              left: AppConstant.searchPaddingLeftRight,
              right: AppConstant.searchPaddingLeftRight,
              bottom: AppConstant.searchPaddingTopBottom,
              top: AppConstant.searchPaddingTopBottom),
          child: Material(
            elevation: 4,
            shadowColor: Colors.black26,
            borderRadius: BorderRadius.circular(AppConstant.borderCircular),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppConstant.borderCircular),
              onTap: () async {
                BottomSheetWidget().settingModalBottomSheet(
                    context: context,
                    adsHeight: sizeConfig.heightSize(context, 11),
                    word: snap.data['turkish'],
                    title: snap.data['english'],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    onTapVoice: () => _dataHelper.speak(snap.data['english']),
                    onTapFav: (bool isLiked) async {
                      String english = snap.data['english'];
                      String turkish = snap.data['turkish'];
                      int favId = snap.data['id'];
                      var patient = Favorite(
                          turkish: turkish, english: english, favId: favId);
                      controllers.wordExists(patient, favId, context);
                      return !isLiked;
                    });
              },
              child: buildContainerText(snap),
            ),
          ),
        );
      },
    );
  }

  Center buildCenter() {
    return Center(
      child: FadeAnimation(
        delay: 0.3,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: AppConstant.searchSizedHeightList,
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
    );
  }

  Material buildContainerText(AlgoliaObjectSnapshot snap) {
    return Material(
      borderRadius: BorderRadius.circular(AppConstant.borderCircular),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppConstant.searchSymmetric,
            horizontal: AppConstant.searchSymmetric),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  snap.data['english'],
                  style: TextStyle(
                      fontSize: AppConstant.fontSizeBody,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: AppConstant.searchSizedHeight,
                ),
                Text(
                  snap.data['turkish'],
                  style: TextStyle(
                      fontSize: AppConstant.searchTextSize,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: AppConstant.searchIconSize,
            )
          ],
        ),
      ),
    );
  }
}
