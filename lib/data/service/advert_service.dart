import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'dart:io';

class AdvertService {
  nativeAds(NativeAdmobType type, NativeAdmobController admobController) {
    return NativeAdmob(
      adUnitID: _getBannerAdUnitId(),
      controller: admobController,
      type: type,
      error: null,
      loading: Center(
          child: Opacity(
              opacity: 1.0,
              child: Container(
                  decoration: BoxDecoration(
                color: Colors.white.withOpacity(1.0),
              )))),
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

  String _getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1002372938729651/8875741991';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1002372938729651/8354577796';
    }
    return null;
  }
}
