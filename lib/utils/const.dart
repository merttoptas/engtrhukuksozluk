import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Constants{

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0XFF2A2E43);
  static Color darkAccent = Color(0XFF2A2E43);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color transparent = Colors.transparent;

  static String applicationId = "WZFSBELAA6";
  static String apiKey = '4c14584cc213e038c3cd6a24650bda91';

  static String aboutText = 'Hukuk Sözlük, bir hukuk fakültesi öğrencisi tarafından geliştirilmiştir. '
      'Hukuk fakültesi öğrencileri ve avukatlar için yardımcı olacak niteliktedir. '
      'Sözlük, hukuk terminolojisini öğrenmek, öğretmek ve geliştirmek amacı güder.'
      'Tarihin ilk çağlarından beri var olan hukukun şahsına münhasır,'
      ' birçok dil ile kaynaşmış terimlerini açıklamak maksadıyla oluşturulmuştur.'
      '\nGün geçtikte kendini yenileyen bu sözlüğün, kelime haznesinin geliştirmesinde siz de yardımcı olabilirsiniz. ';

  static String mail = "mailto:merttoptas34@gmail.com?subject=Konu&body=Öneri%20";
  static String webSite = 'https://merttoptas.com/';
  static String github = 'https://github.com/merttoptas';
  static String webSiteText = 'merttoptas.com';
  static String githubText = 'GitHub: merttoptas';
  static String mailText = 'merttoptas34@gmail.com';



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
          color: darkBG,
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

}