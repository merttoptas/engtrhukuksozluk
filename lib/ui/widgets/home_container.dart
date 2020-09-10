import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeContainerWidget extends StatelessWidget {
  HomeContainerWidget(
      {this.startColour,
      this.endColour,
      this.titleText,
      this.subtitleText,
      this.assetImage,
      this.height});
  final Color startColour, endColour;
  final String titleText, subtitleText;
  final AssetImage assetImage;
  final double height;
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    titleText,
                    style: TextStyle(
                        fontSize: queryData.size.width * 0.066,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 3.0),
                Flexible(
                  child: Text(
                    subtitleText,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: queryData.size.width * 0.040,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Container(
              width: queryData.size.height * 0.15,
              foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: assetImage,
                      alignment: Alignment.centerRight)),
            ),
          ),
        ],
      ),
    );
  }
}
