import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'dart:io';


class AdvertService {
  final _nativeAdController = NativeAdmobController();

  nativeAds(NativeAdmobType type){
   return  NativeAdmob(
      adUnitID: getBannerAdUnitId(),
      controller: _nativeAdController,
      type:type,
      error: null,
      loading: null,
    );
  }

  String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1002372938729651~1668657668';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1002372938729651~1668657668';
    }
    return null;
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1002372938729651/8875741991';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1002372938729651/8354577796';
    }
    return null;
  }

}
