import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  //Colors for theme
  static final Color lightPrimary = Color(0XFF78aaff);
  static final Color darkPrimary = Color(0xFF0A151F);
  static final Color lightAccent = Color(0xFFF8F8F8);
  static final Color darkAccent = Color(0XFF2A2E43);
  static final Color lightBG = Color(0xFFF8F8F8);
  static final Color darkBG = Color(0xFF183148);
  static final Color transparent = Colors.transparent;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: AppConstant.lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    colorScheme: ColorScheme.light(
      primary: lightAccent,
      secondary: lightAccent,
    ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white),
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(color: Color(0XFF3CA3C5)),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: AppConstant.fontSizeBody),
      headline2: TextStyle(
          fontSize: AppConstant.fontSizeBody2, fontWeight: FontWeight.bold),
      caption: TextStyle(
          fontSize: AppConstant.fontSizeCaption, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          fontSize: AppConstant.fontSizeDisplay, fontWeight: FontWeight.bold),
      headline5: TextStyle(
          fontSize: AppConstant.fontSizeDisplay, fontWeight: FontWeight.bold),
    ),
    fontFamily: GoogleFonts.openSans().fontFamily,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(color: darkBG),
    backgroundColor: darkBG,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: darkBG),
    cardColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    colorScheme: ColorScheme.dark(
      primary: darkAccent,
      secondary: darkAccent,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: AppConstant.fontSizeBody),
      headline2: TextStyle(
          fontSize: AppConstant.fontSizeBody2, fontWeight: FontWeight.bold),
      caption: TextStyle(
          fontSize: AppConstant.fontSizeCaption, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          fontSize: AppConstant.fontSizeDisplay, fontWeight: FontWeight.bold),
      headline5: TextStyle(
          fontSize: AppConstant.fontSizeDisplay, fontWeight: FontWeight.bold),
    ),
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    fontFamily: GoogleFonts.openSans().fontFamily,
  );

  static const double fontSizeBody2 = 14;
  static const double fontSizeBody = 16;
  static const double fontSizeDisplay = 28;
  static const double fontSizeCaption = 12;
  static const double fontSizeTitle = 22;
  static const double fontSizeHeadline = 24;
  static const double fontSizeSliderDescription = 20;
  static const double fontSizeIdiomCardContent = 12;

  //Snackbar
  static final int snackBarDuration = 1500;
  static final double snackBarRadius = 6.0;
  static final double snackBarElevotion = 2.0;

  // Border Radius
  static final double borderCircular = 6.0;
  static final double borderCircular45 = 45.0;

  // Algolia id
  static final String applicationId = "WZFSBELAA6";
  static final String apiKey = '4c14584cc213e038c3cd6a24650bda91';

  static final String aboutText =
      'JusTerm bir Hukuk Fakültesi öğrencisi tarafından, hukuk insanlarına yardımcı olmak  '
      'amacıyla geliştirişmiş bir hukuk terimleri sözlüğü uygulamasıdır. '
      '\nGün geçtikte kendini yenileyen bu sözlüğün, kelime haznesinin geliştirmesinde'
      ' siz de yardımcı olmak isterseniz e-posta göndererek katkıda bulunabilirsiniz.';

  //home container
  static final String homeTitle = "JusTerm";
  static final String homeSubtitle =
      "İngilizce ve Türkçe olarak yüzlerce hukuk kelimesi bir arada.";
  static final String learnContainer = 'Kelime Öğrenme   ';
  static final String learnContainerSubTitle =
      'İngilizce ve Türkçe kelimelerle \nalıştırma yapın';
  static final String searchContainer = 'Kelime Arama      ';
  static final String searchContainerSubTitle =
      'Yüzlerce İngilizce - Türkçe \nhukuk kelimesini bulabilirsin';
  static final String favoriteContainer = 'Favorilerim            ';
  static final String favoriteContainerSubTitle =
      'Favorilerine eklediğin  \nkelimeleri burada bulabilirsin';
  static final String aboutContainer = 'Hakkımızda         ';
  static final String aboutContainerSubtitle =
      'Uygulama hakkında bilgiler \nve daha fazlası';

  //about us
  static final String mail =
      "mailto:merttoptas34@gmail.com?subject=Konu&body=Öneri%20";
  static final String webSite = 'https://merttoptas.com/';
  static final String github = 'https://github.com/merttoptas';
  static final String webSiteText = 'merttoptas.com';
  static final String githubText = 'GitHub: merttoptas';
  static final String mailText = 'E-Posta Gönder';

  //strings
  static final String btnLearn = 'BİLİYORUM';
  static final String btnNotLearn = 'BİLMİYORUM';
  static final String learnWord = "Biliyorum";
  static final String notLearnWord = 'Bilmiyorum';
  static final String btn = "ANLAMI GÖRMEK İÇİN DOKUN!";
  static final String btnSearch = "Ara";
  static final String favSnackBarNegative = "Favorilerimde Zaten Var";
  static final String favSnackBarPositive = "Favorilerime Eklendi";
  static final String snackBarDelete = "Başarıyla Silindi";
  static final String backup = "Geri Al";
  static final String appBarFavorite = 'Favorilerim';
  static final String wordLearnTitle = 'Kelime Öğrenme';
  static final String wordsPage = 'Hukuk Kelimeleri';
  static final String hintSearch = "Kelime Arama";
  static final String hintSearching = "Aranıyor bekleyin..";
  static final String defaultSearch = "Henüz arama yapılmadı.";
  static final String btnMeaning = 'ANLAMI GÖRMEK İÇİN DOKUN!';
  static final String slideOneTitle = "Hukuk Sözlüğü";
  static final String slideOneDescription =
      "Yüzlerce İngilizce - Türkçe hukuk kelimeleri sayesinde hukuk literatürü bilgini geliştirebilirsin.";
  static final String slideTwoTitle = "Arama Yap";
  static final String slideTwoDescription =
      "Arama özelliği sayesinde, Hukuk sözlüğünde dilediğin gibi kelimeleri arayabilirsin.";
  static final String slideThreeTitle = "Favorile";
  static final String slideThreeDescription =
      "Tekrar bakman gereken kelimeler olursa, favorileyebilir ve tekrar bakabilirsin.";
  static final String historyTitle = "SON ARAMALAR";
  static final String historyBtn = "TEMİZLE";

  //image Assets
  static final String svgHomeLearn = 'images/home_learn_word.png';
  static final String svgSearch = 'images/transparen_bool.png';
  static final String svgFavorite = 'images/home_ic_biology.png';
  static final String svgAbout = 'images/aboutus.png';
  static final String svgBoard = 'images/board.png';
  static final String svgSlider = 'images/slider.png';
  static final String svgSliderOne = 'images/slider1.png';
  static final String svgSliderSecond = 'images/slider2.png';
  static final String svgAppIcon = 'images/icon2.png';
  static final String svgAppFavorites = 'images/home_favorites.png';

  //database
  static final String historyDatabase = "history.db";
  static final String favoriteDatabase = "favorite.db";

  //version
  static final String appVersion = "1.0.6";

  //page
  static final String pageWords = 'Kelimeler';
  static final String pageSearch = 'Arama';
  static final String pageFavorite = 'Favoriler';
  static final String pageAbout = "Hakkımızda";

  //region Page
  static final String pageSplash = "/";
  static final String pageHome = "/home";
  static final String pageIntro = "/intro";

  // Bottom Tabbar
  static final double barHeight = 60;
  static final Color circleColor = Color(0XFF78aaff);
  static final double circleSize = 42;
  static final double archHeight = 30;
  static final double circleOutline = 10;
  static final double tabIconSize = 30;
  static final double tabFontSize = 14;

  // Appbar
  static final double appBarHeight = 100;
  static final double appBarCircularSize = 50;
  static final double appBarBlurRadius = 10;
  static final double appBarPaddingTop = 30;
  static final double appBarFontSize = 25;
  static final double appBarPreffedSize = 70;
  static final double appBarLetterSpacing = 3.5;

  // Flip Card
  static final double cardPaddingLeftRight = 32;

  //Colors
  static final Color aboutUsBg = Color(0XFF78aaff);

  //About Us Page
  static final double aboutCardSize = 20;
  static final double aboutCirculerSize = 15;
  static final double aboutPaddingTop = 15;
  static final double aboutPaddingLeft = 24;
  static final double aboutPaddingRight = 24;
  static final double aboutPaddingLeftRight = 25;
  static final double aboutStackHeight = 82;
  static final double aboutSizedBoxHeight = 30;
  static final double aboutTextHeight = 2.0;
  static final double aboutElevotion = 5.0;
  static final double aboutLetterSpacing = 1.1;
  static final double aboutUsTextHeight = 2.4;
  static final double aboutSizedBoxTextHeight = 0.5;
  static final double aboutUsLetterSpacing = 1.4;
  static final double aboutUsContainerBgTop = 80;
  static final double aboutUsContainerBgHeight = 100;
  static final double aboutUsImageHeight = 200;
  static final double aboutPositioned = 10;

  //Favorite Page
  static final double favoritePaddingLeftRight = 16.0;
  static final double favoritePaddingTopBottom = 8.0;
  static final double favoritePaddingTextTop = 5.0;
  static final double favoritePaddingTextLeft = 10.0;
  static final double favoritePaddingTextBottom = 3.0;
  static final double favoriteTextFontSize = 16.0;
  static final double favoriteTextRowFontPadding = 10.0;
  static final double favoriteTextRowFontSize = 12.0;
  static final double favoriteImageSize = 350.0;
  static final double favoriteElevation = 4.0;
  static final double favoriteSizedHeight = 3.0;

  //Search page
  static final double searchSymmetric = 15.0;
  static final double searchTextSize = 13.0;
  static final double searchSizedHeight = 3.0;
  static final double searchIconSize = 18.0;
  static final double searchSizedHeightList = 10.0;
  static final double searchPaddingLeftRight = 16.0;
  static final double searchPaddingTopBottom = 8.0;
}
