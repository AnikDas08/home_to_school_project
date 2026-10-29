import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';

class GuardianTripDetailsController extends GetxController {
  static GuardianTripDetailsController get instance =>
      Get.find<GuardianTripDetailsController>();

  int selectedProofTabIndex = 0; // 0: Pickup Handover, 1: Drop-off Handover

  void setProofTabIndex(int index) {
    selectedProofTabIndex = index;
    update();
  }

  void onCallDriver() async {
    const phoneNumber = '+14165550199';
    try {
      const channel = MethodChannel('plugins.flutter.io/url_launcher');
      await channel.invokeMethod('launch', {
        'url': 'tel:$phoneNumber',
        'useSafariVC': false,
        'useWebView': false,
        'enableJavaScript': false,
        'enableDomStorage': false,
        'universalLinksOnly': false,
        'headers': {},
      });
    } catch (_) {}

    Get.snackbar(
      'Calling Driver',
      'Connecting to Tariq Ahmed ($phoneNumber)...',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF1B2B68),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white),
    );
  }

  void onMessageDriver() {
    Get.toNamed(
      AppRoutes.message,
      parameters: {
        'name': 'Tariq Ahmed',
        'chatId': '1',
      },
    );
  }

  void onTrackLiveVehicle() {
    Get.toNamed(AppRoutes.guardianLiveTrack);
  }

  void onSos() {
    Get.toNamed(AppRoutes.sos);
  }

  void onCancelBooking(BuildContext context) {
    Get.defaultDialog(
      title: 'Cancel Booking',
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFFEF4444),
      ),
      middleText:
          'Are you sure you want to cancel this booking with Tariq Ahmed?',
      middleTextStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF64748B),
      ),
      textConfirm: 'Yes, Cancel',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFEF4444),
      textCancel: 'Keep Booking',
      cancelTextColor: const Color(0xFF64748B),
      radius: 16,
      onConfirm: () {
        Get.back(); // close dialog
        Get.back(); // return to bookings list
        Get.snackbar(
          'Booking Cancelled',
          'This trip booking has been cancelled.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF1B2B68),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
    );
  }
}
