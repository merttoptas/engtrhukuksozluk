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
                colors: [Color(0xFFF8F8F8), Color(0xFFF8F8F8)]),
            boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)],
          ),
          child: Align(
          alignment: Alignment.center,
            child: Padding(padding: const EdgeInsets.only(top: 30), child: Text(AppConstant.homeTitle,
              style: GoogleFonts.pacifico(fontSize: 30, fontWeight: FontWeight.w100,
                  letterSpacing: 3.5, color: Colors.black),),),
        ),
        ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(70.0);
}