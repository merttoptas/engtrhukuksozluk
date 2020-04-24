import 'package:engtrhukuksozluk/data/service/advert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Deneme extends StatelessWidget {

  Deneme({Key key, this.height,this.borderRadius, this.startColour,this.endColour}): super(key:key);
  final Color startColour, endColour;
  final double height;
  final BorderRadius borderRadius;
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    AdvertService _advertService = AdvertService();
    queryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [startColour, endColour]),
      ),
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(

                    child: Text('Kelime Öğrenme',
                    style: TextStyle(fontSize: queryData.size.width  * 0.070, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
                SizedBox(height: 5.0),
                Flexible(
                  child: Text('İngilizce ve Türkçe kelimelerle \nalıştırma yapın',
                    style: GoogleFonts.openSans(textStyle:TextStyle(color: Colors.white, fontSize:queryData.size.width  * 0.040, fontWeight: FontWeight.w500) ),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Container(
              width:  queryData.size.height *0.15,
              foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: AssetImage(AppConstant.svgAbout),
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
