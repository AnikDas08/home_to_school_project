import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/widgets/confirm_boarded_bottom_sheet.dart';

class DriverActiveTripController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  /// Whether the driver has arrived at the pickup location (after dragging the slider)
  final isArrived = false.obs;

  /// Whether children have boarded and photo proof has been shared (after bottom sheet confirmation)
  final isPickedUp = false.obs;

  /// Whether a proof photo of children seated has been captured
  final hasProofPhoto = false.obs;

  /// Real captured photo file from device camera if taken
  final photoFile = Rx<File?>(null);

  /// Live GPS status
  final isLiveGpsActive = true.obs;

  /// Trip info
  final tripTime = '07:20 AM'.obs;
  final pickupAddress = '9 Harbourview Lane'.obs;
  final schoolName = 'Greenfield International School'.obs;
  final riders = 'Leo & Mia'.obs;
  final tripStatus = 'On The Way'.obs;

  /// Triggered when the driver slides the slider from left to right (Image 1 -> Image 2)
  void onSlideConfirmed() {
    isArrived.value = true;
    tripStatus.value = 'Arrived';

    Get.snackbar(
      'Arrival Confirmed',
      'You have arrived at $pickupAddress.',
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

  /// Triggered when the driver taps "Confirm child pickup"
  /// Opens the "Confirm children boarded" bottom sheet (Image 1 in new set)
  void onConfirmPickup() {
    Get.bottomSheet(
      const ConfirmBoardedBottomSheet(),
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

  /// Triggered when the driver taps "Confirm pickup & share photo" on the bottom sheet
  void onConfirmPickupAndShare() {
    /// Mark as picked up, close bottom sheet and transition active trip button to "Confirm drop-off"
    isPickedUp.value = true;
    tripStatus.value = 'On The Way';
    Get.back(); // close bottom sheet

    Get.snackbar(
      'Pickup Confirmed',
      hasProofPhoto.value
          ? 'Photo proof shared with parents. Proceed to Greenfield International School.'
          : 'Pickup confirmed. Proceed to Greenfield International School.',
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

  /// Triggered when the driver taps "Confirm drop-off" (Image 5 state)
  void onConfirmDropOff() {
    Get.defaultDialog(
      title: 'Confirm Drop-off',
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      middleText:
          'Have Leo & Mia safely arrived and been handed over at Greenfield International School?',
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
          'Trip Completed! 🎉',
          'Drop-off completed successfully. Great job!',
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

  /// Triggered when the driver taps "Message parent"
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
      'Map centered on your current vehicle position.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
