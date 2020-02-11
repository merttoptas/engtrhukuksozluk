import 'package:engtrhukuksozluk/screens/wordsLearn.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/widgets/homeContainer.dart';
import 'package:engtrhukuksozluk/screens/wordsScreen.dart';

class HomeScreen extends StatelessWidget {

  int selectIndexId;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, top:50.0,right: 20.0),
              child: Text('Hukuk Sözlüğü', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0,top: 5.0, right: 20.0),
              child: Text('İngilizce ve Türkçe olarak yüzlerce hukuk kelimesi bir arada.',
                style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0,right: 20.0, bottom: 5.0),
                child: Center(
                  child: FittedBox(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WordsLearn()));
                      },
                      child: HomeContainerWidget(
                        startColour: Color(0XFFFF416C),
                        endColour: Color(0xFF8A52E9),
                        titleText: 'Kelime Öğrenme     ',
                        subtitleText: 'İngilizce ve Türkçe kelimelerle \nalıştırma yapın',
                        assetImage: AssetImage('images/home_learn_word.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0,right: 20.0, bottom: 5.0),
                child: Center(
                  child: FittedBox(
                    child: InkWell(
                      onTap: (){
                        selectIndexId =1;
                        Navigator.push(context, MaterialPageRoute(builder: (_) => WordsScreen(selectIndexId)));

                        },
                      child: HomeContainerWidget(
                        startColour: Color(0XFF376DF6),
                        endColour: Color(0xFF8A52E9),
                        titleText: 'Kelime Arama      ',
                        subtitleText: 'Yüzlerce İngilizce - Türkçe \nhukuk kelimesini bulabilirsin',
                        assetImage: AssetImage('images/transparen_bool.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0,right: 20.0, bottom: 5.0),
                child: Center(
                  child: FittedBox(
                    child: InkWell(
                      onTap: (){
                        selectIndexId = 2;
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WordsScreen(selectIndexId)));
                         },
                      child: HomeContainerWidget(
                        startColour: Color(0XFFFFC92B),
                        endColour: Color(0XFFFF416C),
                        titleText: 'Favorilerim           ',
                        subtitleText: 'Favorilerine eklediğin  \nkelimeleri burada bulabilirsin',
                        assetImage: AssetImage('images/home_ic_biology.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0,right: 20.0, bottom: 5.0),
                child: Center(
                  child: FittedBox(
                    child: InkWell(
                      onTap: (){
                        selectIndexId = 3;
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => WordsScreen(selectIndexId)));
                      },
                      child: HomeContainerWidget(
                        startColour: Color(0XFF21E8AC),
                        endColour: Color(0XFF376DF6),
                        titleText: 'Hakkımızda        ',
                        subtitleText: 'Uygulama hakkında bilgiler \nve daha fazlası',
                        assetImage: AssetImage('images/aboutus.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      );
  }
}
