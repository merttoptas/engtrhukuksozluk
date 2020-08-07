import 'package:engtrhukuksozluk/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';

class TextCard extends StatelessWidget {
  TextCard({this.valueNotifier1, this.valueNotifier2});

  final ValueNotifier valueNotifier1;
  final ValueNotifier valueNotifier2;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20,top: 20),
      decoration: BoxDecoration(
        color: Color(0XFF78aaff),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        color: Color(0XFF78aaff),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          TitleValueWidget(title: AppConstant.learnWord, valueNotifier: valueNotifier1),
          Spacer(),
          TitleValueWidget(title: AppConstant.notLearnWord, valueNotifier: valueNotifier2),
        ],),

      )
    );
  }
}
// ignore: must_be_immutable
class TitleValueWidget extends StatelessWidget {
  final String title;
  final ValueNotifier valueNotifier;
  SizeConfig _sizeConfig = SizeConfig();
   TitleValueWidget({Key key, this.title, this.valueNotifier})
      : super(key: key);


  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: _sizeConfig.heightSize(context, 2),
              color: Colors.white,
              fontWeight: FontWeight.w600,
            letterSpacing: 1.2
        ),
        ),
        SizedBox(
          height: 10,
        ),
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (ctx, value, __) => Text(
            value.toString(),
            style: TextStyle(
                fontSize:_sizeConfig.heightSize(context, 2),
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2
            ),
          ),
        ),
      ],
    );
  }
}