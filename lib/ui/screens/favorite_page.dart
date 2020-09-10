import 'package:engtrhukuksozluk/ui/widgets/custom_app_bar.dart';
import 'package:engtrhukuksozluk/utils/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/model/favorite.dart';
import 'package:engtrhukuksozluk/data/db/dao/favoriteDao.dart';

class FavoriteWords extends StatefulWidget {
  @override
  _FavoriteWordsState createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {
  Favorite favorite;
  FavoriteDatabase favoriteDatabase;
  FavoriteDao favoriteDao;
  Stream stream;
  List<Favorite> favoriteList;

  @override
  void initState() {
    super.initState();
    builder();
  }

  builder() async {
    favoriteDatabase =
        await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppConstant.pageFavorite,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Favorite>>(
                stream: favoriteDao?.findAllFavoriteStream(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    final favorite = snapshot.data;
                    return favorite.length == 0
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  AppConstant.svgSliderOne,
                                  height: AppConstant.favoriteImageSize,
                                  width: AppConstant.favoriteImageSize,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: favorite.length,
                            itemBuilder: (_, index) {
                              return FadeAnimation(
                                delay: 0.3,
                                child: ListFavorite(
                                  dao: favoriteDao,
                                  favorite: favorite[index],
                                ),
                              );
                            });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ListFavorite extends StatelessWidget {
  const ListFavorite({Key key, @required this.favorite, @required this.dao});
  final FavoriteDao dao;
  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${favorite.hashCode}'),
      background: buildDismissibleBackground(),
      direction: DismissDirection.endToStart,
      child: buildDismissibleBody(context),
      onDismissed: (_) async {
        await dao.deleteFavWord(favorite);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(AppConstant.snackBarDelete),
            duration: Duration(milliseconds: AppConstant.snackBarDuration),
            action: SnackBarAction(
              label: AppConstant.backup,
              onPressed: () {
                dao.insertFavoriteWord(favorite);
              },
            ),
            behavior: SnackBarBehavior.floating,
            elevation: AppConstant.snackBarElevotion,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppConstant.snackBarRadius)),
          ),
        );
      },
    );
  }

  Padding buildDismissibleBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstant.favoritePaddingLeftRight,
          right: AppConstant.favoritePaddingLeftRight,
          bottom: AppConstant.favoritePaddingTopBottom,
          top: AppConstant.favoritePaddingTopBottom),
      child: Material(
        color: Colors.white,
        elevation: AppConstant.favoriteElevation,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(AppConstant.borderCircular),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstant.borderCircular),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: AppConstant.favoritePaddingTextTop,
                        left: AppConstant.favoritePaddingTextLeft,
                        bottom: AppConstant.favoritePaddingTextBottom),
                    child: Text(
                      favorite.english,
                      style: TextStyle(
                          fontSize: AppConstant.favoriteTextFontSize,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppConstant.favoriteSizedHeight,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppConstant.favoritePaddingTextLeft,
                        bottom: AppConstant.favoritePaddingTextLeft),
                    child: Text(
                      favorite.turkish,
                      style: TextStyle(
                          fontSize: AppConstant.favoriteTextRowFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildDismissibleBackground() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstant.favoritePaddingLeftRight,
          right: AppConstant.favoritePaddingLeftRight,
          bottom: AppConstant.favoritePaddingTopBottom,
          top: AppConstant.favoritePaddingTopBottom),
      child: Container(
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          color: Colors.red),
    );
  }
}
