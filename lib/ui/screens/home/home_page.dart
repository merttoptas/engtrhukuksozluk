import 'package:engtrhukuksozluk/ui/widgets/adsWidget.dart';
import 'package:engtrhukuksozluk/ui/widgets/app_bar.dart';
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
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    final AdvertService advertService = AdvertService();
    int selectIndexId;
    return MaterialApp(
      home: Scaffold(
        appBar: HomeAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Expanded(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0,right: 20.0, bottom: 5.0),
                  child:   FittedBox(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => WordsLearn()));},
                      child: HomeContainerWidget(
                        startColour: Color(0XFFFF416C),
                        endColour: Color(0xFF8A52E9),
                        titleText: AppConstant.learnContainer,
                        subtitleText: AppConstant.learnContainerSubTitle,
                        assetImage: AssetImage(AppConstant.svgHomeLearn),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
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
                          startColour: Color(0XFF8A52E9),
                          endColour: Color(0xFF376DF6),
                          titleText: AppConstant.searchContainer,
                          subtitleText: AppConstant.searchContainerSubTitle,
                          assetImage: AssetImage(AppConstant.svgSearch),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: GestureDetector(
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
                          startColour: Color(0XFFFFC92B),
                          endColour: Color(0XFFFF416C),
                          titleText: AppConstant.favoriteContainer,
                          subtitleText: AppConstant.favoriteContainerSubTitle,
                          assetImage: AssetImage(AppConstant.svgFavorite),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
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
                          startColour: Color(0XFF21e8ac),
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
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: AdsWidget(
                borderRadius: BorderRadius.circular(15),
                height:MediaQuery.of(context).size.height * 0.13,
                type: NativeAdmobType.banner,),
            ),
          ],
        ),
        ),
      );
  }
}

