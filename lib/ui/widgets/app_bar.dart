import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0XFF3CA3C5),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffa1c4fd), Color(0xffc2e9fb)]),
            boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)],
          ),
          child: Align(
          alignment: Alignment.center,
            child: Padding(padding: const EdgeInsets.only(top: 40), child: Text(AppConstant.homeTitle,
              style: GoogleFonts.pacifico(fontSize: 35,
                  letterSpacing: 3.5, color: Colors.black54),),),
        ),
        ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(70.0);
}