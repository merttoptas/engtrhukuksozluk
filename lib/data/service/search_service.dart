import 'package:algolia/algolia.dart';
import "package:engtrhukuksozluk/utils/app_const.dart";
import 'package:flutter/cupertino.dart';

class SearchService {

   algolia(){
     Algolia algolia = Algolia.init(
       applicationId: AppConstant.applicationId,
       apiKey: AppConstant.apiKey,

     );

     return algolia;
   }

}

