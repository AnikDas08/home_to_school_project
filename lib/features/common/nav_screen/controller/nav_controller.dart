import 'package:get/get.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class NavController extends GetxController {
  int selectedIndex = 0;
  String currentRole = '';

  static NavController get instance => Get.find<NavController>();

  @override
  void onInit() {
    super.onInit();
    syncRoleFromStorage();
  }

  /// Sync active role from storage
  void syncRoleFromStorage() {
    final stored = LocalStorage.role.isNotEmpty
        ? LocalStorage.role
        : (LocalStorage.myRole.isNotEmpty ? LocalStorage.myRole : 'Parent');
    currentRole = stored;
    update();
  }

  /// Switch role dynamically and reset to Home tab (index 0)
  Future<void> switchRole(String newRole) async {
    currentRole = newRole;
    selectedIndex = 0;
    LocalStorage.role = newRole;
    LocalStorage.myRole = newRole;
    await LocalStorage.saveRole(newRole);
    update();
  }

  /// Change the selected tab index
  void changeIndex(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    update();
  }

  /// Force update tab view
  void refreshIndex() {
    syncRoleFromStorage();
    update();
  }

  /// Reset back to Home tab (index 0)
  void resetToHome() {
    selectedIndex = 0;
    syncRoleFromStorage();
    update();
  }
}

/// Type alias for compatibility with service_user_app structure
typedef HomeNavController = NavController;
