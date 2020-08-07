import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant{

  //Colors for theme
  static final Color lightPrimary = Color(0XFF78aaff);
  static final Color darkPrimary = Color(0xFF0A151F);
  static final Color lightAccent = Color(0xFFF8F8F8);
  static final Color darkAccent = Color(0XFF2A2E43);
  static final Color lightBG = Color(0xFFF8F8F8);
  static final Color darkBG = Color(0xFF183148);
  static final Color transparent = Colors.transparent;


  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.openSans().fontFamily,
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static const double fontSizeBody2 = 14;
  static const double fontSizeBody = 16;
  static const double fontSizeDisplay = 28;
  static const double fontSizeCaption = 12;
  static const double fontSizeTitle = 22;
  static const double fontSizeHeadline = 24;
  static const double fontSizeSliderDescription = 20;
  static const double fontSizeIdiomCardContent = 12;



  // Algolia id
  static final String applicationId = "WZFSBELAA6";
  static final String apiKey = '4c14584cc213e038c3cd6a24650bda91';

  static final String aboutText = 'JusTerm bir Hukuk Fakültesi öğrencisi tarafından, hukuk insanlarına yardımcı olmak  '
      'amacıyla geliştirişmiş bir hukuk terimleri sözlüğü uygulamasıdır. '
      '\nGün geçtikte kendini yenileyen bu sözlüğün, kelime haznesinin geliştirmesinde'
      ' siz de yardımcı olmak isterseniz e-posta göndererek katkıda bulunabilirsiniz.';



  //home container
  static final String homeTitle ="JusTerm";
  static final String homeSubtitle = "İngilizce ve Türkçe olarak yüzlerce hukuk kelimesi bir arada.";
  static final String learnContainer = 'Kelime Öğrenme   ';
  static final String learnContainerSubTitle = 'İngilizce ve Türkçe kelimelerle \nalıştırma yapın';
  static final String searchContainer = 'Kelime Arama      ';
  static final String searchContainerSubTitle= 'Yüzlerce İngilizce - Türkçe \nhukuk kelimesini bulabilirsin';
  static final String favoriteContainer = 'Favorilerim            ';
  static final String favoriteContainerSubTitle ='Favorilerine eklediğin  \nkelimeleri burada bulabilirsin';
  static final String aboutContainer = 'Hakkımızda         ';
  static final String aboutContainerSubtitle = 'Uygulama hakkında bilgiler \nve daha fazlası';


  //about us
  static final String mail = "mailto:merttoptas34@gmail.com?subject=Konu&body=Öneri%20";
  static final String webSite = 'https://merttoptas.com/';
  static final String github = 'https://github.com/merttoptas';
  static final String webSiteText = 'merttoptas.com';
  static final String githubText = 'GitHub: merttoptas';
  static final String mailText = 'E-Posta Gönder';


  //strings
  static final String btnLearn ='BİLİYORUM';
  static final String btnNotLearn = 'BİLMİYORUM';
  static final String learnWord = "Biliyorum";
  static final String notLearnWord = 'Bilmiyorum';
  static final String btn  ="ANLAMI GÖRMEK İÇİN DOKUN!";
  static final String btnSearch = "Ara";
  static final String favSnackBarNegative = "Favorilerimde Zaten Var";
  static final String favSnackBarPositive = "Favorilerime Eklendi";
  static final String snackBarDelete = "Başarıyla Silindi";
  static final String backup = "Geri Al";
  static final String appBarFavorite = 'Favorilerim';
  static final String wordLearnTitle = 'Kelime Öğrenme';
  static final String wordsPage = 'Hukuk Kelimeleri';
  static final String hintSearch = "Kelime Arama";
  static final String hintSearching ="Aranıyor bekleyin..";
  static final String defaultSearch = "Henüz arama yapılmadı.";
  static final String btnMeaning = 'ANLAMI GÖRMEK İÇİN DOKUN!';
  static final String slideOneTitle = "Hukuk Sözlüğü";
  static final String slideOneDescription= "Yüzlerce İngilizce - Türkçe hukuk kelimeleri sayesinde hukuk literatürü bilgini geliştirebilirsin.";
  static final String slideTwoTitle = "Arama Yap";
  static final String slideTwoDescription= "Arama özelliği sayesinde, Hukuk sözlüğünde dilediğin gibi kelimeleri arayabilirsin.";
  static final String slideThreeTitle = "Favorile";
  static final String slideThreeDescription= "Tekrar bakman gereken kelimeler olursa, favorileyebilir ve tekrar bakabilirsin.";
  static final String historyTitle  = "SON ARAMALAR";
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



  //page
  static final String pageWords = 'Kelimeler';
  static final String pageSearch = 'Arama';
  static final String pageFavorite = 'Favoriler';
  static final String pageAbout = "Hakkımızda";

  //region Page
  static final String pageSplash = "/";
  static final String pageHome = "/home";
  static final String pageIntro ="/intro";


}