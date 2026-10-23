import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/helpers/other_helper.dart';

class AddChildController extends GetxController {
  static AddChildController get instance => Get.find<AddChildController>();

  final nameController = TextEditingController();
  final schoolController = TextEditingController();
  final gradeController = TextEditingController();

  String? image;
  bool isLoading = false;

  final List<String> gradeOptions = [
    'Kindergarten',
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
    'Grade 6',
    'Grade 7',
    'Grade 8',
    'Grade 9',
    'Grade 10',
    'Grade 11',
    'Grade 12',
  ];

  Future<void> openGallery() async {
    image = await OtherHelper.pickImage();
    update();
  }

  void selectGrade(String grade) {
    gradeController.text = grade;
    update();
  }

  Future<void> saveChildInfo() async {
    if (nameController.text.trim().isEmpty) {
      AppSnackbar.error(
        title: 'Child Name Required',
        message: 'Please enter child\'s full name',
      );
      return;
    }

    // Direct navigation for design phase (API call commented out)
    Get.offAllNamed(AppRoutes.home);

    // if (isLoading) return;
    // try {
    //   isLoading = true;
    //   update();
    //   // TODO: Call child registration API endpoint
    //   Get.offAllNamed(AppRoutes.signIn);
    // } catch (e) {
    //   AppSnackbar.error(title: 'Error', message: e.toString());
    // } finally {
    //   isLoading = false;
    //   update();
    // }
  }

  @override
  void onClose() {
    nameController.dispose();
    schoolController.dispose();
    gradeController.dispose();
    super.onClose();
  }
}
