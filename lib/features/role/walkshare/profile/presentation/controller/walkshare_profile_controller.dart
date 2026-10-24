import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class WalkshareProfileController extends GetxController {
  static WalkshareProfileController get instance =>
      Get.find<WalkshareProfileController>();

  String name = 'Robert MacDonald';
  String roleDescription = 'WalkShare Guide';
  String rating = '4.9';
  int walkCount = 142;
  String activeRole = 'WalkShare';

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
    }
    update();
  }

  void toggleOnline(bool value) {
    isOnline = value;
    update();

    Get.snackbar(
      isOnline ? 'Online' : 'Offline',
      isOnline
          ? 'You are now online and accepting new walk requests.'
          : 'You are now offline. Walk requests are paused.',
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

  void onSwitchRole(BuildContext context) {
    SwitchRoleDialog.show(context);
  }

  void onEditProfile() {
    Get.toNamed(AppRoutes.personalInformation);
  }

  void onAboutTap(BuildContext context) {
    Get.toNamed(AppRoutes.about);
  }

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
          'Are you sure you want to log out of your WalkShare account?',
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
