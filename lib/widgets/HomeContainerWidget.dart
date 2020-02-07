import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeContainerWidget extends StatelessWidget {
  HomeContainerWidget({this.startColour, this.endColour,this.titleText, this.subtitleText, this.assetImage});
  Color startColour, endColour;
  String titleText, subtitleText;
  AssetImage assetImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [startColour, endColour]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, top:30.0,right: 20.0, bottom: 30.0),
            child: Column(
              children: <Widget>[
                Text( titleText,
                  style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w600,),),
                SizedBox(height: 10.0),
                Text(subtitleText,
                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          Container(
              height: 100,
              width:160,
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0,right: 10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image(
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      image: assetImage,
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
