import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/controller/driver_active_trip_controller.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/screen/pickup_camera_screen.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ConfirmBoardedBottomSheet extends StatelessWidget {
  const ConfirmBoardedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverActiveTripController>();
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
            /// Top Header Row: "Confirm children boarded" & "Close"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonText(
                  text: 'Confirm children boarded',
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
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ],
                      ),

                      /// Optional badge
                      if (!controller.hasProofPhoto.value)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const CommonText(
                            text: 'Optional',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                    ],
                  ),

                  8.height,

                  /// Description
                  CommonText(
                    text: controller.hasProofPhoto.value
                        ? 'Photo of the children seated in your vehicle.'
                        : 'Take a live photo of the children seated in your vehicle (optional). Parents see it in their booking.',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                    textAlign: TextAlign.start,
                  ),

                  14.height,

                  /// Captured Photo Thumbnail
                  if (controller.hasProofPhoto.value && controller.photoFile.value != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        width: double.infinity,
                        height: 140.h,
                        child: Image.file(
                          controller.photoFile.value!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    12.height,
                  ],

                  /// "Open camera" or "Retake photo" Button
                  GestureDetector(
                    onTap: () => Get.to(() => const PickupCameraScreen()),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 18.sp,
                            color: const Color(0xFF1B2B68),
                          ),
                          8.width,
                          CommonText(
                            text: controller.hasProofPhoto.value
                                ? 'Retake photo'
                                : 'Open camera',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1B2B68),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            16.height,

            /// Confirm Pickup & Share Photo Button
            GestureDetector(
              onTap: controller.onConfirmPickupAndShare,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 54.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1B2B68).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: CommonText(
                    text: 'Confirm pickup',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
