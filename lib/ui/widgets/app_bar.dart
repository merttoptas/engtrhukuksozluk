import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppConstant.appBarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: AppConstant.appBarBg,
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(AppConstant.appBarCircularSize)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppConstant.lightAccent, AppConstant.lightAccent]),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: AppConstant.appBarBlurRadius)
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: AppConstant.appBarPaddingTop),
            child: Text(
              AppConstant.homeTitle,
              style: GoogleFonts.pacifico(
                  fontSize: AppConstant.appBarFontSize,
                  fontWeight: FontWeight.w100,
                  letterSpacing: AppConstant.appBarLetterSpacing,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstant.appBarPreffedSize);
}
