import 'package:flutter/material.dart';
class textCard extends StatelessWidget {
  textCard({ this.text, this.number});
  String text;
  String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:20.0,top: 10,right: 20.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 5.0,right: 20.0),
          child: Text(
            number,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    );
  }
}
