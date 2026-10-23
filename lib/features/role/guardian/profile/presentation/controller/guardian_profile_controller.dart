import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class GuardianProfileController extends GetxController {
  static GuardianProfileController get instance =>
      Get.find<GuardianProfileController>();

  String name = 'Sadia Khan';
  String roleDescription = 'Parent (Mother)';
  String rating = '5.0';
  int reviewCount = 12;
  int childrenCount = 3;
  String activeRole = 'Parent';

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
  }

  void _loadProfileData() {
    if (LocalStorage.myName.isNotEmpty) {
      name = LocalStorage.myName;
    } else if (LocalStorage.user?.name.isNotEmpty == true) {
      name = LocalStorage.user!.name;
    }

    if (LocalStorage.role.isNotEmpty) {
      activeRole = LocalStorage.role.contains('Parent') ||
              LocalStorage.role.contains('Guardian')
          ? 'Parent'
          : LocalStorage.role;
    }
    update();
  }

  /// Switch role dialog
  void onSwitchRole(BuildContext context) {
    SwitchRoleDialog.show(context);
  }

  /// Edit profile navigation (Personal Information)
  void onEditProfile() {
    Get.toNamed(AppRoutes.personalInformation);
  }

  /// Logout action
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
          'Are you sure you want to log out of your account?',
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
