import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentVerificationController extends GetxController {
  static StudentVerificationController get instance =>
      Get.find<StudentVerificationController>();

  final TextEditingController institutionController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();

  /// Once signup is complete and user is in the app, this is strictly Read-Only
  bool get isReadOnly => Get.arguments?['isRegistration'] != true;

  @override
  void onInit() {
    super.onInit();
    if (isReadOnly) {
      institutionController.text = 'Seneca College';
      studentIdController.text = 'STU-992184';
    }
  }

  void submitVerification() {
    if (isReadOnly) return;

    AppSnackbar.success(
      title: 'Submitted Successfully',
      message: 'Your Student verification has been submitted for review!',
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAllNamed(AppRoutes.navScreen);
    });
  }

  @override
  void onClose() {
    institutionController.dispose();
    studentIdController.dispose();
    super.onClose();
  }
}
