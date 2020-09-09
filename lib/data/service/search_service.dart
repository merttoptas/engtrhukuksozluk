import 'package:algolia/algolia.dart';
import "package:engtrhukuksozluk/utils/app_const.dart";

class SearchService {
  algolia() {
    Algolia algolia = Algolia.init(
      applicationId: AppConstant.applicationId,
      apiKey: AppConstant.apiKey,
    );

    return algolia;
  }
}