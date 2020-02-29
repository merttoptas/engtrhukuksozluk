import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ListTileCard extends StatelessWidget {
  ListTileCard({this.onPressed,this.text,this.icon});
  Function onPressed;
  String text;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Color(0XFF2A2E43),
      margin: EdgeInsets.all(10.0),
      elevation: 2.0,
      child: ListTile(
        onTap: onPressed,
        leading: CircleAvatar(
          backgroundColor: Colors.white, radius:15, child:icon,),
        title: Text(text, style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.white,letterSpacing: 1.2)),),
      ),
    );
  }
}
