import 'package:engtrhukuksozluk/ui/widgets/adsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:engtrhukuksozluk/data/db/dao/FavoriteDao.dart';
import 'package:engtrhukuksozluk/ui/widgets/homeContainer.dart';
import 'package:engtrhukuksozluk/ui/screens/words_learn_page.dart';
import 'package:engtrhukuksozluk/ui/screens/home/words_navigator_page.dart';
import 'package:engtrhukuksozluk/data/service/advert_service.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.favoriteDao}): super(key:key);

  final FavoriteDao favoriteDao;
  final AdvertService advertService = AdvertService();

  @override
  Widget build(BuildContext context) {
    final AdvertService advertService = AdvertService();
    int selectIndexId;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, top:50.0,right: 20.0),
                child: Text(AppConstant.homeTitle, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0,top: 5.0, right: 20.0),
              child: Text(AppConstant.homeSubtitle,
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.normal),),
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0,right: 20.0, bottom: 5.0),
                child:   FittedBox(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => WordsLearn()));},
                    child: HomeContainerWidget(
                      /*
                       startColour: Color(0XFFFF416C),
                      endColour: Color(0xFF8A52E9),
                       */
                      startColour: Color(0XFF2A2E43),
                      endColour: Color(0XFF376DF6),
                      titleText: AppConstant.learnContainer,
                      subtitleText: AppConstant.learnContainerSubTitle,
                      assetImage: AssetImage(AppConstant.svgHomeLearn),
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
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => WordsScreen(selectIndexId: selectIndexId,)));
                        },
                      child: HomeContainerWidget(
                        /*
                          startColour: Color(0XFF376DF6),
                        endColour: Color(0xFF8A52E9),
                         */
                        startColour: Color(0XFF2A2E43),
                        endColour: Color(0XFF376DF6),
                        titleText: AppConstant.searchContainer,
                        subtitleText: AppConstant.searchContainerSubTitle,
                        assetImage: AssetImage(AppConstant.svgSearch),
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
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => WordsScreen(selectIndexId: selectIndexId,)));
                      },
                      child: HomeContainerWidget(
                        startColour: Color(0XFF2A2E43),
                        endColour: Color(0XFF376DF6),
                        /*
                        startColour: Color(0XFFFFC92B),
                        endColour: Color(0XFFFF416C),
                         */
                        titleText: AppConstant.favoriteContainer,
                        subtitleText: AppConstant.favoriteContainerSubTitle,
                        assetImage: AssetImage(AppConstant.svgFavorite),
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
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => WordsScreen(selectIndexId: selectIndexId,)));
                      },
                      child: HomeContainerWidget(
                        startColour: Color(0XFF2A2E43),
                        endColour: Color(0XFF376DF6),
                        titleText: AppConstant.aboutContainer,
                        subtitleText: AppConstant.aboutContainerSubtitle,
                        assetImage: AssetImage(AppConstant.svgAbout),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: AdsWidget(borderRadius: BorderRadius.circular(15), height: 100.0,type: NativeAdmobType.banner,),
            ),
          ],
        ),
        ),
      );
  }
}
