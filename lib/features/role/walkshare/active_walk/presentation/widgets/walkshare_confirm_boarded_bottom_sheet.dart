import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/controller/walkshare_active_walk_controller.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/screen/walkshare_pickup_camera_screen.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareConfirmBoardedBottomSheet extends StatelessWidget {
  const WalkshareConfirmBoardedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalkshareActiveWalkController>();
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        16.w,
        18.h,
        16.w,
        bottomPadding > 0 ? bottomPadding + 10.h : 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Header Row: "Confirm children assembled" & "Close"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonText(
                  text: 'Confirm children assembled',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: CommonText(
                      text: 'Close',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B2B68),
                    ),
                  ),
                ),
              ],
            ),

            14.height,

            /// Card: Pickup Photo Proof
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title & Required Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 18.sp,
                            color: const Color(0xFF1E293B),
                          ),
                          8.width,
                          const CommonText(
                            text: 'Pickup photo proof',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const CommonText(
                          text: 'Required',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFEA580C),
                        ),
                      ),
                    ],
                  ),

                  6.height,

                  /// Subtitle
                  const CommonText(
                    text:
                        'Take a live photo of the children assembled for walking. Parents see it in their booking.',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),

                  12.height,

                  /// Photo Preview or Camera Button
                  if (controller.hasProofPhoto.value && controller.photoFile.value != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 140.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Image.file(
                          controller.photoFile.value!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    12.height,
                    OutlinedButton.icon(
                      onPressed: () =>
                          Get.to(() => const WalksharePickupCameraScreen()),
                      icon: const Icon(
                        Icons.refresh_rounded,
                        size: 18,
                        color: Color(0xFF1B2B68),
                      ),
                      label: const Text(
                        'Retake photo',
                        style: TextStyle(
                          color: Color(0xFF1B2B68),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        minimumSize: Size(double.infinity, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ] else ...[
                    ElevatedButton.icon(
                      onPressed: () =>
                          Get.to(() => const WalksharePickupCameraScreen()),
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: Color(0xFF1B2B68),
                      ),
                      label: const Text(
                        'Open camera',
                        style: TextStyle(
                          color: Color(0xFF1B2B68),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: Size(double.infinity, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            16.height,

            /// Confirm pickup & share photo button
            GestureDetector(
              onTap: controller.onConfirmPickupAndShare,
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1B2B68).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                    8.width,
                    const CommonText(
                      text: 'Confirm pickup & share photo',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
