import 'package:get/get.dart';

class NavController extends GetxController {
  int selectedIndex = 0;

  static NavController get instance => Get.find<NavController>();

  /// Change the selected tab index
  void changeIndex(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    update();
  }

  /// Force update tab view
  void refreshIndex() {
    update();
  }

  /// Reset back to Home tab (index 0)
  void resetToHome() {
    selectedIndex = 0;
    update();
  }
}

/// Type alias for compatibility with service_user_app structure
typedef HomeNavController = NavController;
