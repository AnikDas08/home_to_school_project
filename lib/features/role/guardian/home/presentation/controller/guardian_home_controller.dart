import 'package:get/get.dart';

class GuardianHomeController extends GetxController {
  static GuardianHomeController get instance => Get.find<GuardianHomeController>();

  int currentNavIndex = 0;

  void changeNavIndex(int index) {
    currentNavIndex = index;
    update();
  }
}
