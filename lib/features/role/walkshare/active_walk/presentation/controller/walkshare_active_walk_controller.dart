import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/widgets/walkshare_confirm_boarded_bottom_sheet.dart';

class WalkshareActiveWalkController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  /// Whether the walker has arrived at the pickup location (after dragging the slider)
  final isArrived = false.obs;

  /// Whether children have met/joined and photo proof has been shared
  final isPickedUp = false.obs;

  /// Whether a proof photo of children walking/assembled has been captured
  final hasProofPhoto = false.obs;

  /// Real captured photo file from device camera if taken
  final photoFile = Rx<File?>(null);

  /// Live GPS status
  final isLiveGpsActive = true.obs;

  /// Walk info
  final tripTime = '07:20 AM'.obs;
  final pickupAddress = '9 Harbourview Lane'.obs;
  final schoolName = 'Greenfield International School'.obs;
  final riders = 'Leo & Mia'.obs;
  final tripStatus = 'On The Way'.obs;

  /// Triggered when the user slides the slider from left to right
  void onSlideConfirmed() {
    isArrived.value = true;
    tripStatus.value = 'Arrived';

    Get.snackbar(
      'Arrival Confirmed',
      'You have arrived at ${pickupAddress.value}.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF1B2B68),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Color(0xFF22C55E),
      ),
    );
  }

  /// Triggered when the walker taps "Confirm child pickup"
  void onConfirmPickup() {
    Get.bottomSheet(
      const WalkshareConfirmBoardedBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Called when the photo is captured and approved from the camera screen
  void onPhotoCaptured([File? file]) {
    if (file != null) {
      photoFile.value = file;
    }
    hasProofPhoto.value = true;
  }

  /// Opens the native device camera using image_picker
  Future<void> openDeviceCameraPicker() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (image != null) {
        photoFile.value = File(image.path);
        hasProofPhoto.value = true;
      }
    } catch (e) {
      debugPrint('Error picking from camera: $e');
    }
  }

  /// Triggered when tapping "Confirm pickup & share photo" on the bottom sheet
  void onConfirmPickupAndShare() {
    /// Mark as picked up, close bottom sheet and transition to "Confirm drop-off"
    isPickedUp.value = true;
    tripStatus.value = 'On The Way';
    Get.back(); // close bottom sheet

    Get.snackbar(
      'Pickup Confirmed',
      hasProofPhoto.value
          ? 'Photo proof shared with parents. Proceed walking to ${schoolName.value}.'
          : 'Pickup confirmed. Proceed walking to ${schoolName.value}.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF1B2B68),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Color(0xFF22C55E),
      ),
    );
  }

  /// Triggered when tapping "Confirm drop-off"
  void onConfirmDropOff() {
    Get.defaultDialog(
      title: 'Confirm School Arrival',
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      middleText:
          'Have ${riders.value} safely arrived and been handed over at ${schoolName.value}?',
      middleTextStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF64748B),
      ),
      textConfirm: 'Confirm Drop-off',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF1B2B68),
      textCancel: 'Cancel',
      cancelTextColor: const Color(0xFF64748B),
      radius: 16,
      onConfirm: () {
        Get.back(); // close dialog
        if (Get.isRegistered<NavController>()) {
          Get.find<NavController>().resetToHome();
        }
        Get.offAllNamed(AppRoutes.navScreen);
        Get.snackbar(
          'Walk Completed! 🎉',
          'Children safely accompanied to school. Great job!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF1B2B68),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(
            Icons.school_rounded,
            color: Color(0xFF22C55E),
          ),
        );
      },
    );
  }

  /// Triggered when tapping "Message parent"
  void onMessageParent() {
    Get.toNamed(AppRoutes.message);
  }

  /// Emergency SOS button tapped
  void onSosTap() {
    Get.toNamed(AppRoutes.sos);
  }

  /// Tapping the compass/navigation recenter button
  void onRecenterMap() {
    Get.snackbar(
      'Navigation',
      'Map centered on your current walking location.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
