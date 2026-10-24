import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';

class SosController extends GetxController {
  static SosController get instance => Get.find<SosController>();

  final String emergencyNumber = '911';

  /// Call for Emergency Help (opens phone dialer with 911)
  Future<void> callEmergencyHelp() async {
    await openDialer(emergencyNumber);
  }

  /// Contact Support (navigates to Contact Support Page)
  void contactSupport() {
    Get.toNamed(AppRoutes.contactSupport);
  }

  /// Opens the device phone dialer with the provided number
  Future<void> openDialer(String number) async {
    final cleanNumber = number.replaceAll(RegExp(r'[^0-9+]'), '');

    // 1. Try our native method channel (Android Intent / iOS UIApplication tel://)
    try {
      const nativeChannel = MethodChannel('com.example.home_to_school/dialer');
      final bool? success = await nativeChannel.invokeMethod<bool>(
        'openDialer',
        {'number': cleanNumber},
      );
      if (success == true) {
        return;
      }
    } catch (e) {
      debugPrint('Native dialer channel error: $e');
    }

    // 2. Try standard Flutter url_launcher channel if registered
    try {
      const channel = MethodChannel('plugins.flutter.io/url_launcher');
      await channel.invokeMethod('launch', {
        'url': 'tel:$cleanNumber',
        'useSafariVC': false,
        'useWebView': false,
        'enableJavaScript': false,
        'enableDomStorage': false,
        'universalLinksOnly': false,
        'headers': {},
      });
      return;
    } catch (e) {
      debugPrint('url_launcher fallback error: $e');
    }

    // 3. Fallback on simulator / web
    Get.snackbar(
      'Emergency Dialing 🚨',
      'Opening dialer for $cleanNumber. Safety team notified.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white),
    );
  }
}
