import 'package:engtrhukuksozluk/data/service/value_controller.dart';
import 'package:engtrhukuksozluk/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:get/get.dart';

class TextCard extends StatefulWidget {
  @override
  _TextCardState createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  final controller = Get.put(ValueController());

  final ValueController ctrl = Get.find();

  SizeConfig _sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20, top: 20),
        decoration: BoxDecoration(
          color: Color(0XFF78aaff),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          color: Color(0XFF78aaff),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TitleValueWidget(
                title: AppConstant.learnWord,
                getx: GetX<ValueController>(
                  builder: (_) => Text(
                    '${ctrl.countLearn}',
                    style: TextStyle(
                        fontSize: _sizeConfig.heightSize(context, 2),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              Spacer(),
              TitleValueWidget(
                title: AppConstant.notLearnWord,
                getx: GetX<ValueController>(
                  builder: (_) => Text(
                    '${ctrl.countNotLearn}',
                    style: TextStyle(
                        fontSize: _sizeConfig.heightSize(context, 2),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class TitleValueWidget extends StatelessWidget {
  final String title;
  final ValueController ctrl = Get.find();
  final GetX getx;

  SizeConfig _sizeConfig = SizeConfig();
  TitleValueWidget({Key key, this.title, this.getx}) : super(key: key);

  @override
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
              letterSpacing: 1.2),
        ),
        SizedBox(
          height: 10,
        ),
        getx,
      ],
    );
  }
}