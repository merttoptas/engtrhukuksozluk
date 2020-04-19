import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContainerWidget extends StatelessWidget {
  HomeContainerWidget({this.startColour, this.endColour,this.titleText, this.subtitleText, this.assetImage});
  final Color startColour, endColour;
  final String titleText, subtitleText;
  final AssetImage assetImage;
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return  FittedBox(
      fit: BoxFit.cover,
      child: Container(
          height:  queryData.size.height * 0.20,

          decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 5),
              )
            ],
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [startColour, endColour]),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, top:30.0,right: 30.0),
                child: Column(
                  children: <Widget>[
                    Text( titleText,
                      style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.white, fontSize:30.0, fontWeight: FontWeight.w600,)),),
                    SizedBox(height: 10.0),
                    Text(subtitleText,
                      style: GoogleFonts.openSans(textStyle:TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600) ),),
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Container(
                  width:180,
                  foregroundDecoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: assetImage,
                          alignment: Alignment.centerRight
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
