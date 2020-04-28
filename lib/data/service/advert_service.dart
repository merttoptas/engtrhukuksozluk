import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform;

class AdvertService {
  //static final AdvertService _instance = AdvertService._internal();
  //MobileAdTargetingInfo targetingInfo;
  static String _bannerId =   Platform.isAndroid
      ? 'ca-app-pub-1002372938729651/1201753809'
      : 'ca-app-pub-1002372938729651/7102657602';
  static BannerAd _bannerAd;
  final String testDevice = 'YOUR_DEVICE_ID';

    initialize() {
     var nativeAdmob = NativeAdmob(adUnitID: _bannerId);

  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  showBanner(){
     return BannerAd(
      adUnitId: _bannerId,
      size: AdSize.smartBanner,
      targetingInfo:targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

  }
  static final _controller = NativeAdmobController();

  nativeAd(NativeAdmobType type){
    return  NativeAdmob(
      adUnitID:_bannerId,
      loading: Center(child: CircularProgressIndicator(),),
      error: null,
      controller: _controller,
      type: type,
      options: NativeAdmobOptions(
          ratingColor: Colors.white
      ),

    );
  }
  showInterstitial(){
   return  FirebaseAdMob.instance.initialize(
        appId: _bannerId
    );
  }
}