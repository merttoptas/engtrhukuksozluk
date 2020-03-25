import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileCard extends StatelessWidget {
  ListTileCard({this.onPressed,this.text,this.icon});
  final Function onPressed;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 40,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0XFF2A2E43), radius:14, child:icon,),
                  title:Text(text, style: GoogleFonts.openSans(textStyle:
                        TextStyle(fontSize: 12.0,fontWeight: FontWeight.w500,
                            color: Colors.black,letterSpacing: 1.2),
                  ),
                  ),
                  ),
              ),
          ),
          SizedBox(height: 5.0,)
        ],
      ),
    );
  }
}
