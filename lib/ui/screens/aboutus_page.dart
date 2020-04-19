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

  @override
  Widget build(BuildContext context) {
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
                  Positioned(
                    top: 85.0,
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
                    top: 25.0,
                    left: (MediaQuery.of(context).size.width/2)-100,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstant.svgAbout),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                  Positioned(
                    top: 240.0,
                    left: 25.0,
                    right: 25.0,
                    child: Column(
                      children: <Widget>[
                        Text('Hakkımızda', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: 1.4)),),
                        SizedBox(height: 15.0,),
                        Text(AppConstant.aboutText,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 1.1)),
                        ),
                        SizedBox(height: 10.0,),
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