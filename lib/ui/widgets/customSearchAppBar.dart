import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomSearchAppBar(
      {this.controller,
      this.focusNode,
      this.searching,
      this.function,
      this.btnFunction});
  TextEditingController controller;
  FocusNode focusNode;
  bool searching;
  Function function, btnFunction;
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
              colors: [AppConstant.lightPrimary, AppConstant.lightPrimary]),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40.0, bottom: 8, right: 10, left: 35),
          child: Row(
            children: <Widget>[buildContainer(), buildPaddingButton()],
          ),
        ),
      ),
    );
  }

  Flexible buildContainer() {
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0XFF78aaff)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[buildFlexible(), buildIconButton()],
          ),
        ),
      ),
    );
  }

  Padding buildPaddingButton() {
    return Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: FlatButton(
        onPressed: btnFunction,
        color: Color(0XFF78aaff),
        child: Text(
          AppConstant.btnSearch,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.3),
        ),
      ),
    );
  }

  IconButton buildIconButton() {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: AppConstant.darkBG,
        size: 20,
      ),
      onPressed: function,
    );
  }

  Flexible buildFlexible() {
    return Flexible(
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: AppConstant.hintSearch,
          hintStyle: TextStyle(fontSize: 12, color: AppConstant.darkBG),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Container(
            margin: EdgeInsets.only(bottom: 0),
            child: Icon(
              Icons.search,
              color: AppConstant.darkBG,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
