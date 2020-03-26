import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';


class BottomSheetWidget {
  void settingModalBottomSheet({BuildContext context,String word, String title,
    Function onTapFav, Function onTapVoice, Function onPressed}){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(child: _buildDetailItem(word: word,title: title,
                onTapVoice: onTapVoice, onTapFav: onTapFav, onPressed: onPressed ),
                decoration: _bottomSheetBoxDecoration),
          );
        });
}

  Widget _itemTopMenu({BuildContext context, String heading, Function onTapFav,
    Function onTapVoice, Function onPressed}) => Padding(
    padding: const EdgeInsets.only(top: 32.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new RawMaterialButton(
          onPressed: onPressed,
          child: new Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 13.0,
          ),
          shape: new CircleBorder(),
          elevation: 0,
          padding: const EdgeInsets.all(15.0),
        ),
        Spacer(flex: 4,),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(heading,
            style: TextStyle(fontSize: 16, color:  Colors.black,  fontWeight: FontWeight.w600),
          ),
        ),
        Spacer(flex: 4,),
        Row(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black38,
              child: InkWell(
                onTap: onTapVoice,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 40,
                  width: 40,
                  child: Center(child: Icon(Icons.settings_voice)),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black38,
              child: Container(
                height: 40,
                width: 40,
                child: Center(
                  child: LikeButton(
                    onTap: onTapFav,
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red : Colors.black,
                        size: 24.0,
                      );
                    },
                  ),
                ),
              ),

            ),
          ],
        ),
      ],
    ),
  );

  Widget _pullDown(Color color) => Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        width: 58,
        height: 4,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
    ),
  );

  Widget _buildDetailItem({String title, String word, Function onTapFav, Function onTapVoice, Function onPressed}) => Column(
    children: <Widget>[
      _pullDown(Colors.black45),
      _itemTopMenu(heading: title, onTapFav: onTapFav, onTapVoice: onTapVoice, onPressed: onPressed),
      Divider(),
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(
              height: 30,
            ),
            Material(
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black38,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: word ,style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );


  static BoxDecoration get _bottomSheetBoxDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: const Radius.circular(15.0),
      topRight: const Radius.circular(15.0),
    ),
  );

}