import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class DriverRoleProfileController extends GetxController {
  static DriverRoleProfileController get instance =>
      Get.find<DriverRoleProfileController>();

  String name = 'Robert MacDonald';
  String roleDescription = 'Driver';
  String rating = '4.9';
  int tripCount = 142;
  String activeRole = 'Parent';

  /// Online/Offline status switch
  bool isOnline = true;

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
  }

  void _loadProfileData() {
    if (LocalStorage.myName.isNotEmpty) {
      name = LocalStorage.myName;
    }

    if (LocalStorage.role.isNotEmpty) {
      activeRole = LocalStorage.role;
      if (activeRole.toLowerCase().contains('walk')) {
        roleDescription = 'WalkShare Guide';
      } else {
        roleDescription = 'Driver';
      }
    }
    update();
  }

  /// Toggle Online status
  void toggleOnline(bool value) {
    isOnline = value;
    update();

    Get.snackbar(
      isOnline ? 'Online' : 'Offline',
      isOnline
          ? 'You are now online and accepting new trip requests.'
          : 'You are now offline. Trip requests are paused.',
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          isOnline ? const Color(0xFF1B2B68) : const Color(0xFF64748B),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: Icon(
        isOnline ? Icons.check_circle_rounded : Icons.pause_circle_rounded,
        color: isOnline ? const Color(0xFF22C55E) : Colors.white,
      ),
    );
  }

  /// Switch role dialog
  void onSwitchRole(BuildContext context) {
    SwitchRoleDialog.show(context);
  }

  /// Edit profile navigation
  void onEditProfile() {
    Get.toNamed(AppRoutes.personalInformation);
  }

  /// Show About Home2School screen
  void onAboutTap(BuildContext context) {
    Get.toNamed(AppRoutes.about);
  }

  /// Logout confirmation dialog
  void onLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of your driver account?',
          style: TextStyle(
            color: Color(0xFF64748B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await LocalStorage.removeAllPrefData();
              Get.offAllNamed(AppRoutes.signIn);
            },
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
