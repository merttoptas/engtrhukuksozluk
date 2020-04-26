import 'package:engtrhukuksozluk/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/widgets/listTileCard.dart';
import 'package:google_fonts/google_fonts.dart';
class AboutUs extends StatefulWidget {

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  MediaQueryData queryData;
  SizeConfig _sizeConfig = SizeConfig();
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          color: Color(0XFF78aaff),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 82.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white ,
                      ),
                      height: MediaQuery.of(context).size.height -100.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    left: (MediaQuery.of(context).size.width/2)-100,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppConstant.svgAbout),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: queryData.size.height * 0.25,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: _sizeConfig.heightSize(context, 30),),
                        Text(AppConstant.pageAbout, style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: _sizeConfig.heightSize(context, 2.4), color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: 1.4)),),
                        SizedBox(height:_sizeConfig.heightSize(context, 2),),
                        Text(AppConstant.aboutText,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: _sizeConfig.heightSize(context, 2.0), color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 1.1)),
                        ),
                        SizedBox(height: _sizeConfig.heightSize(context, 2),),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0, left: 24.0,right: 24.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5.0,
                            child: Column(
                              children: <Widget>[
                                ListTileCard(text: AppConstant.webSiteText,
                                  icon: Icon(Icons.home, color: Colors.white, size: 20.0,),
                                  onPressed: (){
                                    _launchURL(AppConstant.webSite);
                                  },),
                                ListTileCard(text: AppConstant.githubText,
                                  icon: Icon(Icons.star, color: Colors.white, size: 20.0,),
                                  onPressed: (){
                                    _launchURL(AppConstant.github);
                                  },),
                                ListTileCard(text: AppConstant.mailText,
                                  icon: Icon(Icons.alternate_email, color:Colors.white, size: 20.0,),
                                  onPressed: (){
                                    _launchURL(AppConstant.mail);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}