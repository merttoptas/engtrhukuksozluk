import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
class wordsRowWidget extends StatelessWidget {
  wordsRowWidget({this.text,this.onButtonPress, this.onTap});

  String text;
  Function onButtonPress, onTap;
  bool isLiked=false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Material(
                color: Colors.white,
                elevation: 4,
                shadowColor: Colors.black26,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: InkWell(
                    onTap:onTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5.0, left: 10.0),
                              child: Text(text,

                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0,top: 5.0),
                              child: Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppConstant.lightAccent,
                                  size: 18,
                                )
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
