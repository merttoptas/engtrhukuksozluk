import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class wordsRowWidget extends StatelessWidget {
  wordsRowWidget({this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 2.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.white,
                ),
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
                            style: TextStyle(fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0,top: 5.0),
                          child: Container(
                            child:LikeButton(
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color: isLiked ? Colors.red : Colors.grey,
                                  size: 24.0,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
