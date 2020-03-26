import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DataHelper with ChangeNotifier{
  final FlutterTts flutterTts = FlutterTts();

  Future speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);

  }
}