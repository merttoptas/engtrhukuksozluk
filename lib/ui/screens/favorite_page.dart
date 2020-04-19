import 'package:flutter/material.dart';

import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/data/db/database/database.dart';
import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';

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

  builder() async{
    favoriteDatabase = await $FloorFavoriteDatabase.databaseBuilder("favorite.db").build();
    setState(() {
      favoriteDao = favoriteDatabase.favoriteDao;
    });
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
        centerTitle: true,
        backgroundColor: Color(0XFF78aaff),

        title: Text(
          AppConstant.appBarFavorite,
          style: TextStyle(color: Colors.white),
        ),

        brightness: Brightness.light,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Favorite>>(
                stream: favoriteDao?.findAllFavoriteStream(),
                 builder: (_, snapshot){
                  if(!snapshot.hasData){
                    return Container();
                  }else
                    {
                    final favorite = snapshot.data;
                    return ListView.builder(
                        itemCount: favorite.length,
                        itemBuilder: (_, index) {
                          return ListFavorite(
                            dao: favoriteDao,
                            favorite: favorite[index],
                          );
                        }
                    );
                  }
            }),
          ),
        ],
      ),
    );
  }
}

class ListFavorite extends StatelessWidget{
  const ListFavorite({Key key, @required this.favorite, @required this.dao});
  final FavoriteDao dao;
  final Favorite favorite;


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${favorite.hashCode}'),
      background: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16.0,bottom: 8,top: 8),
        child: Container(
          child: Icon(Icons.delete, color: Colors.white,),
            color: Colors.red),
      ),
      direction: DismissDirection.endToStart,
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16.0,bottom: 8,top: 8),
        child:  Material(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 10.0, bottom: 3.0),
                      child: Text(favorite.english, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
                SizedBox(height: 3.0,),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                      child: Text(favorite.turkish, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (_)async{
        await dao.deleteFavWord(favorite);
        Scaffold.of(context).showSnackBar(
            SnackBar(content:  Text(AppConstant.snackBarDelete),
              duration: Duration(milliseconds: 1500),
              action: SnackBarAction(
                label: AppConstant.backup,
                onPressed: (){
                  dao.insertFavoriteWord(favorite);
                },
              ),
              behavior: SnackBarBehavior.floating,
              elevation: 2.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
            ),);
      },
    );
  }
}
