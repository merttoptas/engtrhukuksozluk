import 'package:engtrhukuksozluk/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/ui/widgets/list_tile_card.dart';
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
                  buildContainer(context),
                  buildContainerBg(context),
                  buildImageAbout(context),
                  buildColumText(context)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildContainerBg(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppConstant.aboutUsContainerBgTop),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstant.borderCircular45),
            topRight: Radius.circular(AppConstant.borderCircular45),
          ),
          color: Theme.of(context).cardColor,
        ),
        height: MediaQuery.of(context).size.height -
            AppConstant.aboutUsContainerBgHeight,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - AppConstant.aboutStackHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
    );
  }

  Padding buildColumText(BuildContext context) {
    return Padding(
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
                    fontSize: _sizeConfig.heightSize(
                        context, AppConstant.aboutUsTextHeight),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: AppConstant.aboutUsLetterSpacing)),
          ),
          SizedBox(
            height:
                _sizeConfig.heightSize(context, AppConstant.aboutTextHeight),
          ),
          Text(
            AppConstant.aboutText,
            textAlign: TextAlign.justify,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: _sizeConfig.heightSize(
                        context, AppConstant.aboutTextHeight),
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: AppConstant.aboutLetterSpacing)),
          ),
          SizedBox(
            height: _sizeConfig.heightSize(
                context, AppConstant.aboutSizedBoxTextHeight),
          ),
          buildVersion(context),
          SizedBox(
            height:
                _sizeConfig.heightSize(context, AppConstant.aboutTextHeight),
          ),
          buildAboutCard(),
        ],
      ),
    );
  }

  Row buildVersion(BuildContext context) {
    return Row(
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
                  letterSpacing: AppConstant.aboutLetterSpacing)),
        ),
        Text(
          AppConstant.appVersion,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: _sizeConfig.heightSize(
                      context, AppConstant.aboutTextHeight),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: AppConstant.aboutLetterSpacing)),
        ),
      ],
    );
  }

  Positioned buildImageAbout(BuildContext context) {
    return Positioned(
      top: AppConstant.aboutPositioned,
      left: (MediaQuery.of(context).size.width / 2) -
          AppConstant.aboutUsContainerBgHeight,
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
            width: AppConstant.aboutUsImageHeight,
          ),
        ],
      ),
    );
  }

  Padding buildAboutCard() {
    return Padding(
      padding: EdgeInsets.only(
          top: AppConstant.aboutPaddingTop,
          left: AppConstant.aboutPaddingLeft,
          right: AppConstant.aboutPaddingRight),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstant.aboutCirculerSize),
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
                  color: Colors.white, size: AppConstant.aboutCardSize),
              onPressed: () {
                _launchURL(AppConstant.mail);
              },
            ),
          ],
        ),
      ),
    );
  }
}