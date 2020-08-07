import 'package:engtrhukuksozluk/ui/screens/home/home_page.dart';
import 'package:engtrhukuksozluk/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/cupertino.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  bool checkValue = false;

  Function goToTab;
  SharedPreferences sharedPreferences;
  SizeConfig _sizeConfig = SizeConfig();

  @override
  void initState() {
    super.initState();
    restorePrefData();

    slides.add(
      new Slide(
        title: AppConstant.slideOneTitle,
        styleTitle: TextStyle(
            color: AppConstant.lightPrimary,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description: AppConstant.slideOneDescription,
        styleDescription: TextStyle(
          color: AppConstant.darkPrimary,
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
        ),
        pathImage: AppConstant.svgSlider,
      ),
    );
    slides.add(
      new Slide(
        title: AppConstant.slideTwoTitle,
        styleTitle: TextStyle(
            color: AppConstant.lightPrimary,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description: AppConstant.slideTwoDescription,
        styleDescription: TextStyle(
          color: AppConstant.darkPrimary,
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
        ),
        pathImage: AppConstant.svgSliderOne,
      ),
    );
    slides.add(
      new Slide(
        title: AppConstant.slideThreeTitle,
        styleTitle: TextStyle(
            color: AppConstant.lightPrimary,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description: AppConstant.slideThreeDescription,
        styleDescription: TextStyle(
          color: AppConstant.darkPrimary,
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
        ),
        pathImage: AppConstant.svgSliderSecond,
      ),
    );
  }

  void onDonePress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Back to the first tab
    setState(() {
      prefs.setBool('boolValue', true);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => HomeScreen()),
      );
    });

    this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }
  restorePrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    setState(() {
      checkValue = prefs.getBool("boolValue");
      if (checkValue != null) {
        checkValue = prefs.getBool("boolValue");
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => HomeScreen()),
        );
      }
      return checkValue;
    });
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: AppConstant.lightPrimary,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: AppConstant.lightPrimary,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: AppConstant.lightPrimary,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.all(50),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: _sizeConfig.widthSize(context, 50),
                height: _sizeConfig.heightSize(context, 50),
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 10.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: AppConstant.lightBG,
      highlightColorSkipBtn: AppConstant.lightBG,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: AppConstant.lightBG,
      highlightColorDoneBtn: AppConstant.lightBG,

      // Dot indicator
      colorDot: AppConstant.lightPrimary,
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),

      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
      // Show or hide status bar
      shouldHideStatusBar: false,
      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
