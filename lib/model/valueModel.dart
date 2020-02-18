import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

var model = ValueModel();

class ValueModel{
  ValueNotifier onValue1Change;
  ValueNotifier onValue2Change;

  int _value1 = 0;
  int _value2 = 0;

  // accessor methods (getters, and setters)
  int get value2=> _value2;

  set value2(int value){
    onValue2Change.value = _value2 =value;
  }
  int get value1 => _value1;
    //
  set value1(int value){
    onValue1Change.value = _value1 =value;
  }

  //constructor
  ValueModel() {
    onValue1Change = ValueNotifier(_value1);
    onValue2Change = ValueNotifier(_value2);
  }
}