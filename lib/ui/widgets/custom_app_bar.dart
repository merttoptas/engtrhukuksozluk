import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.color,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
