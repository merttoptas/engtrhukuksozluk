import 'package:algolia/algolia.dart';
import "package:engtrhukuksozluk/utils/app_const.dart";
import 'package:flutter/cupertino.dart';

TextEditingController _searchText = TextEditingController(text: "");

List<AlgoliaObjectSnapshot> _results = [];
bool _searching = false;

Algolia algolia = Algolia.init(
  applicationId: AppConstant.applicationId,
  apiKey: AppConstant.apiKey,
);
class SearchService {

   algolia(){
     Algolia algolia = Algolia.init(
       applicationId: AppConstant.applicationId,
       apiKey: AppConstant.apiKey,

     );

     return algolia;
   }
}

