import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianLiveTrackController extends GetxController {
  static GuardianLiveTrackController get instance =>
      Get.find<GuardianLiveTrackController>();

  final RxDouble zoomLevel = 1.0.obs;
  final RxBool isLiveGps = true.obs;

  void onSosTap() {
    Get.toNamed(AppRoutes.sos);
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

  void onTripDetails() {
    if (Get.previousRoute == AppRoutes.tripDetails) {
      Get.back();
    } else {
      Get.toNamed(AppRoutes.tripDetails);
    }
  }

  void onReportIssue(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            16.height,
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                ),
                12.width,
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Report an Issue',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                      CommonText(
                        text: 'Let our safety team know immediately',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            20.height,
            _buildReportOption(
              ctx,
              icon: Icons.timer_outlined,
              title: 'Driver is delayed / off route',
            ),
            _buildReportOption(
              ctx,
              icon: Icons.car_crash_outlined,
              title: 'Vehicle driving concern',
            ),
            _buildReportOption(
              ctx,
              icon: Icons.phone_disabled_outlined,
              title: 'Cannot reach driver',
            ),
            _buildReportOption(
              ctx,
              icon: Icons.help_outline_rounded,
              title: 'Other safety concern',
            ),
            12.height,
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Get.snackbar(
          'Issue Reported',
          'Thank you. Our safety monitoring team has been notified.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF0F172A),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: const Color(0xFF64748B)),
            14.width,
            Expanded(
              child: CommonText(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  void onRecenterMap() {
    zoomLevel.value = 1.0;
    Get.snackbar(
      'Location Centered',
      'Tracking centered on vehicle.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onZoomIn() {
    if (zoomLevel.value < 1.8) {
      zoomLevel.value += 0.2;
    }
  }

  void onZoomOut() {
    if (zoomLevel.value > 0.6) {
      zoomLevel.value -= 0.2;
    }
  }
}
