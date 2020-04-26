
import 'package:flutter/cupertino.dart';

class SizeConfig{

  double heightSize(BuildContext context, double value){
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(BuildContext context,double value ){
    value /=100;
    return MediaQuery.of(context).size.width * value;
  }
}