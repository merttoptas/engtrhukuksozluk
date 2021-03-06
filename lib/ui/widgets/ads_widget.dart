import 'package:engtrhukuksozluk/data/service/advert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget(
      {Key key,
      this.height,
      this.borderRadius,
      @required this.type,
      this.admobController})
      : super(key: key);

  final double height;
  final BorderRadius borderRadius;
  final NativeAdmobType type;
  final NativeAdmobController admobController;
  @override
  Widget build(BuildContext context) {
    AdvertService _advertService = AdvertService();
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      padding: EdgeInsets.all(10),
      height: height,
      child: _advertService.nativeAds(type, admobController),
    );
  }
}