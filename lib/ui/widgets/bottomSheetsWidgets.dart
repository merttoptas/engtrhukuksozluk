import 'package:engtrhukuksozluk/ui/widgets/adsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:like_button/like_button.dart';

class BottomSheetWidget {
  void settingModalBottomSheet(
      {BuildContext context,
      String word,
      String title,
      Function onTapFav,
      Function onTapVoice,
      Function onPressed,
      double adsHeight}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.49,
            child: Container(
                child: _buildDetailItem(
                    word: word,
                    title: title,
                    onTapVoice: onTapVoice,
                    onTapFav: onTapFav,
                    onPressed: onPressed,
                    adsHeight: adsHeight),
                decoration: _bottomSheetBoxDecoration),
          );
        });
  }

  Widget _itemTopMenu(
          {BuildContext context,
          String heading,
          Function onTapFav,
          Function onTapVoice,
          Function onPressed}) =>
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              constraints: BoxConstraints(minWidth: 5, minHeight: 30.0),
              onPressed: onPressed,
              child: new Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 15.0,
              ),
              elevation: 0,
            ),
            Spacer(
              flex: 4,
            ), // 1st spacer

            Container(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  heading,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Spacer(
              flex: 3,
            ), // 1st spacer
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                child: Row(
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
                      width: 5,
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
                                size: 26.0,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(14))),
          ),
        ),
      );

  Widget _buildDetailItem(
          {String title,
          String word,
          Function onTapFav,
          Function onTapVoice,
          Function onPressed,
          BuildContext context,
          double adsHeight}) =>
      Column(
        children: <Widget>[
          _pullDown(Colors.black45),
          _itemTopMenu(
              heading: title,
              onTapFav: onTapFav,
              onTapVoice: onTapVoice,
              onPressed: onPressed),
          Divider(),
          Spacer(),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black38,
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 9,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: word,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: AdsWidget(
              borderRadius: BorderRadius.circular(8),
              height: adsHeight,
              type: NativeAdmobType.banner,
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
