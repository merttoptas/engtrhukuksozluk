import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeContainerWidget extends StatelessWidget {
  HomeContainerWidget({this.startColour, this.endColour,this.titleText, this.subtitleText, this.assetImage});
  final Color startColour, endColour;
  final String titleText, subtitleText;
  final AssetImage assetImage;
  MediaQueryData queryData;
  
  static ScreenUtil _instance;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    ScreenUtil.init(context, height:queryData.size.height, width: queryData.size.width,allowFontScaling: false);

    return  Container(
        height:  ScreenUtil().setHeight(130),
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
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, top:30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(titleText,
                      style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.white, fontSize:20, fontWeight: FontWeight.w600,)),),
                  ),
                  SizedBox(height: 10.0),
                  Text(subtitleText,
                    style: GoogleFonts.openSans(textStyle:TextStyle(color: Colors.white, fontSize:18, fontWeight: FontWeight.w600) ),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                width:  ScreenUtil().setWidth(130),
                foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: assetImage,
                        alignment: Alignment.centerRight
                    )
                ),
              ),
            ),
          ],
        ),
      );
  }
}
