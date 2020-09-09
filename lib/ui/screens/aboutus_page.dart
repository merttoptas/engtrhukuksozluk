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
  MediaQueryData queryData;

  SizeConfig _sizeConfig = SizeConfig();

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          color: AppConstant.aboutUsBg,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height -
                        AppConstant.aboutStackHeight,
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
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height - 100.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    left: (MediaQuery.of(context).size.width / 2) - 100,
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
                    padding: EdgeInsets.only(
                        left: AppConstant.aboutPaddingLeftRight,
                        right: AppConstant.aboutPaddingLeftRight),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: _sizeConfig.heightSize(
                              context, AppConstant.aboutSizedBoxHeight),
                        ),
                        Text(
                          AppConstant.pageAbout,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize:
                                      _sizeConfig.heightSize(context, AppConstant.aboutUsTextHeight),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: AppConstant.aboutUsLetterSpacing)),
                        ),
                        SizedBox(
                          height: _sizeConfig.heightSize(
                              context, AppConstant.aboutSizedBoxHeight),
                        ),
                        Text(
                          AppConstant.aboutText,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize:
                                      _sizeConfig.heightSize(context, AppConstant.aboutTextHeight),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing:
                                      AppConstant.aboutLetterSpacing)),
                        ),
                        SizedBox(
                          height: _sizeConfig.heightSize(context, AppConstant.aboutSizedBoxTextHeight),
                        ),
                        Row(
                          children: [
                            Text(
                              'Version: ',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: _sizeConfig.heightSize(
                                          context, AppConstant.aboutTextHeight),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing:
                                          AppConstant.aboutLetterSpacing)),
                            ),
                            Text(
                              AppConstant.appVersion,
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: _sizeConfig.heightSize(
                                          context, AppConstant.aboutTextHeight),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing:
                                          AppConstant.aboutLetterSpacing)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _sizeConfig.heightSize(
                              context, AppConstant.aboutTextHeight),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppConstant.aboutPaddingTop,
                              left: AppConstant.aboutPaddingLeft,
                              right: AppConstant.aboutPaddingRight),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppConstant.aboutCirculerSize),
                            ),
                            elevation: AppConstant.aboutElevotion,
                            child: Column(
                              children: <Widget>[
                                ListTileCard(
                                  text: AppConstant.webSiteText,
                                  icon: Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: AppConstant.aboutCardSize,
                                  ),
                                  onPressed: () {
                                    _launchURL(AppConstant.webSite);
                                  },
                                ),
                                ListTileCard(
                                  text: AppConstant.githubText,
                                  icon: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: AppConstant.aboutCardSize,
                                  ),
                                  onPressed: () {
                                    _launchURL(AppConstant.github);
                                  },
                                ),
                                ListTileCard(
                                  text: AppConstant.mailText,
                                  icon: Icon(Icons.alternate_email,
                                      color: Colors.white,
                                      size: AppConstant.aboutCardSize),
                                  onPressed: () {
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