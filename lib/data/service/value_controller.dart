import 'package:get/get.dart';

class ValueController extends GetxController {
  var countLearn = 0.obs;
  var countNotLearn = 0.obs;
  void incrementLearn() {
    countLearn++;
  }

  void incrementNotLearn() {
    countNotLearn++;
  }
}
