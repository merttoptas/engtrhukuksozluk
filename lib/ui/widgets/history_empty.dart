import 'package:flutter/material.dart';

class HistoryEmpty extends StatelessWidget {
  const HistoryEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.history,
              color: Color(0xFFC6CBD2),
              size: 48,
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              'Aradığınız sözcük bulunamadı. ',
            )
          ],
        ),
      ),
    );
  }
}
