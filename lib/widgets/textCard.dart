import 'package:flutter/material.dart';
class textCard extends StatelessWidget {

  final ValueNotifier valueNotifier1;
  final ValueNotifier valueNotifier2;

  textCard({this.valueNotifier1, this.valueNotifier2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30.0, left: 30.0, top: 30.0,bottom: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Container(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          TitleValueWidget(title: 'Öğrenilen', valueNotifier: valueNotifier1),
          Spacer(),
          TitleValueWidget(title: 'Bilinmeyen', valueNotifier: valueNotifier2),
        ],),

      )
    );
  }
}
class TitleValueWidget extends StatelessWidget {
  final String title;
  final ValueNotifier valueNotifier;
  const TitleValueWidget({Key key, this.title, this.valueNotifier})
      : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
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
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2
            ),
          ),
        ),
      ],
    );
  }
}