import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class ChangePasswordController extends GetxController {
  bool isLoading = false;
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController get currentPasswordController {
    try {
      final _ = _currentPasswordController.value;
      return _currentPasswordController;
    } catch (_) {
      _currentPasswordController = TextEditingController();
      return _currentPasswordController;
    }
  }

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController {
    try {
      final _ = _newPasswordController.value;
      return _newPasswordController;
    } catch (_) {
      _newPasswordController = TextEditingController();
      return _newPasswordController;
    }
  }

  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController get confirmPasswordController {
    try {
      final _ = _confirmPasswordController.value;
      return _confirmPasswordController;
    } catch (_) {
      _confirmPasswordController = TextEditingController();
      return _confirmPasswordController;
    }
  }

  Future<void> changePassword() async {
    if (isLoading) return;
    try {
      isLoading = true;
      update();

      AppSnackbar.success(
        title: 'Success',
        message: 'Password changed successfully.',
      );
      Get.back();
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
