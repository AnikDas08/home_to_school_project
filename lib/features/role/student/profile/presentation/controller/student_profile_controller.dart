import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentProfileController extends GetxController {
  static StudentProfileController get instance =>
      Get.find<StudentProfileController>();

  String studentName = 'Alex Morgan';
  String studentEmail = 'alex.morgan@senecacollege.ca';
  String activeRole = 'Student (18+)';
  String roleDescription = 'Verified College Student';
  String institution = 'Seneca College';
  String campus = 'Newnham Campus';
  String studentId = 'STU-992184';
  String rating = '4.95';
  int ridesCount = 48;
  bool isVerified = true;

  @override
  void onInit() {
    super.onInit();
    syncData();
  }

  void syncData() {
    if (LocalStorage.myName.isNotEmpty) {
      studentName = LocalStorage.myName;
    } else if (LocalStorage.user?.name.isNotEmpty == true) {
      studentName = LocalStorage.user!.name;
    }

    if (LocalStorage.myEmail.isNotEmpty) {
      studentEmail = LocalStorage.myEmail;
    } else if (LocalStorage.user?.email.isNotEmpty == true) {
      studentEmail = LocalStorage.user!.email;
    }

    if (LocalStorage.role.isNotEmpty) {
      activeRole = LocalStorage.role;
    }
    update();
  }

  void onEditProfile() {
    Get.toNamed(AppRoutes.personalInformation);
  }

  void openStudentId() {
    Get.toNamed(AppRoutes.studentIdVerification);
  }

  void openSavedLocations() {
    Get.toNamed(AppRoutes.savedLocations);
  }

  void openFavourites() {
    Get.toNamed(AppRoutes.favourites);
  }

  void openEmergencyContacts() {
    Get.toNamed(AppRoutes.emergencyContacts);
  }

  void openBilling() {
    Get.toNamed(AppRoutes.billingAndTransactions);
  }

  void openContactSupport() {
    Get.toNamed(AppRoutes.contactSupport);
  }

  void openFaq() {
    Get.toNamed(AppRoutes.faq);
  }

  void openPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  void openTermsOfService() {
    Get.toNamed(AppRoutes.termsOfServices);
  }

  void openAbout() {
    Get.toNamed(AppRoutes.about);
  }

  void showSwitchRole(BuildContext context) {
    SwitchRoleDialog.show(context);
  }

  void logout(BuildContext context) {
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

