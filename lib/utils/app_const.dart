import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant{

  //Colors for theme
  static final Color lightPrimary = Color(0XFF2A2E43);
  static final Color darkPrimary = Color(0xFF0A151F);
  static final Color lightAccent = Color(0XFF2A2E43);
  static final Color darkAccent = Color(0XFF2A2E43);
  static final Color lightBG = Color(0xFFF8F8F8);
  static final Color darkBG = Color(0xFF183148);
  static final Color transparent = Colors.transparent;

  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.openSans().fontFamily,
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
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
  static const double fontSizeIdiomCardTitle = 18;
  static const double fontSizeIdiomCardContent = 12;



  // Algolia id
  static final String applicationId = "WZFSBELAA6";
  static final String apiKey = '4c14584cc213e038c3cd6a24650bda91';

  static final String aboutText = 'Hukuk Sözlük, bir hukuk fakültesi öğrencisi tarafından geliştirilmiştir. '
      'Hukuk fakültesi öğrencileri ve avukatlar için yardımcı olacak niteliktedir. '
      'Sözlük, hukuk terminolojisini öğrenmek, öğretmek ve geliştirmek amacı güder.'
      'Tarihin ilk çağlarından beri var olan hukukun şahsına münhasır,'
      ' birçok dil ile kaynaşmış terimlerini açıklamak maksadıyla oluşturulmuştur.'
      '\nGün geçtikte kendini yenileyen bu sözlüğün, kelime haznesinin geliştirmesinde siz de yardımcı olabilirsiniz. ';



  //home container
  static final String homeTitle ="Hukuk Sözlüğü";
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
  static final String learnWord = "Öğrenilen";
  static final String notLearnWord = 'Bilinmeyen';
  static final String btn  ="ANLAMI GÖRMEK İÇİN DOKUN!";
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


  //image Assets
  static final String svgHomeLearn = 'images/home_learn_word.png';
  static final String svgSearch = 'images/transparen_bool.png';
  static final String svgFavorite = 'images/home_ic_biology.png';
  static final String svgAbout = 'images/aboutus.png';
  static final String svgBoard = 'images/board.png';

  //page
  static final String pageWords = 'Kelimeler';
  static final String pageSearch = 'Arama';
  static final String pageFavorite = 'Favoriler';
  static final String pageAbout = "Hakkımızda";

  //region Page
  static final String pageSplash = "/";
  static final String pageHome = "/home";


}