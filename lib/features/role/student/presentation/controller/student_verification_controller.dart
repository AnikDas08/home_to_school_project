import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentVerificationController extends GetxController {
  static StudentVerificationController get instance =>
      Get.find<StudentVerificationController>();

  final ImagePicker _picker = ImagePicker();

  final TextEditingController institutionController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();

  File? idFrontPhoto;
  File? idBackPhoto;
  String? idFrontFileName;
  String? idBackFileName;

  /// Once signup is complete and user is in the app, this is strictly Read-Only
  bool get isReadOnly => Get.arguments?['isRegistration'] != true;

  @override
  void onInit() {
    super.onInit();
    if (isReadOnly) {
      institutionController.text = 'Seneca College';
      studentIdController.text = 'STU-992184';
      idFrontFileName = 'student_id_front.jpg';
      idBackFileName = 'student_id_back.jpg';
    }
  }

  String _formatFileName(String rawName) {
    String name = rawName.split('/').last;
    if (name.contains(String.fromCharCode(92))) {
      name = name.split(String.fromCharCode(92)).last;
    }
    if (name.isEmpty) return 'student_id.jpg';
    if (name.length > 25) {
      final extIndex = name.lastIndexOf('.');
      if (extIndex != -1 && extIndex < name.length) {
        final ext = name.substring(extIndex);
        final base = name.substring(0, extIndex);
        return '${base.substring(0, 16.clamp(0, base.length))}...$ext';
      }
      return '${name.substring(0, 20)}...';
    }
    return name;
  }

  Future<void> pickIdFront(ImageSource source) async {
    if (isReadOnly) return;
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        idFrontPhoto = File(file.path);
        idFrontFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      idFrontFileName = 'student_id_front.jpg';
      update();
    }
  }

  void removeIdFront() {
    if (isReadOnly) return;
    idFrontPhoto = null;
    idFrontFileName = null;
    update();
  }

  Future<void> pickIdBack(ImageSource source) async {
    if (isReadOnly) return;
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        idBackPhoto = File(file.path);
        idBackFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      idBackFileName = 'student_id_back.jpg';
      update();
    }
  }

  void removeIdBack() {
    if (isReadOnly) return;
    idBackPhoto = null;
    idBackFileName = null;
    update();
  }

  void submitVerification() {
    if (isReadOnly) return;
    if (idFrontPhoto == null && idFrontFileName == null) {
      AppSnackbar.error(
        title: 'Front Photo Required',
        message: 'Please upload the front side of your student ID card.',
      );
      return;
    }

    if (idBackPhoto == null && idBackFileName == null) {
      AppSnackbar.error(
        title: 'Back Photo Required',
        message: 'Please upload the back side of your student ID card.',
      );
      return;
    }

    AppSnackbar.success(
      title: 'Submitted Successfully',
      message: 'Your Student ID has been submitted for verification review!',
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

