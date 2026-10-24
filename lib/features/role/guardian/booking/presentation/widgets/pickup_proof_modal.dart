import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/guardian_trip_details_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class PickupProofModal extends StatelessWidget {
  const PickupProofModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (ctx) => const Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: PickupProofModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuardianTripDetailsController());

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: GetBuilder<GuardianTripDetailsController>(
        builder: (_) {
          final isPickup = controller.selectedProofTabIndex == 0;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 1. Top Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 20.sp,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: 'Pickup Proof',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                        2.height,
                        const CommonText(
                          text: 'Verification Record',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              16.height,

              /// 2. Segmented Tabs: "Pickup Handover" vs "Drop-off Handover"
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    /// Tab 1: Pickup Handover
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.setProofTabIndex(0),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: isPickup ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(9.r),
                            boxShadow: isPickup
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                size: 16.sp,
                                color: isPickup
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFF64748B),
                              ),
                              6.width,
                              CommonText(
                                text: 'Pickup Handover',
                                fontSize: 12.5,
                                fontWeight: isPickup
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isPickup
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF64748B),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Tab 2: Drop-off Handover
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.setProofTabIndex(1),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color:
                                !isPickup ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(9.r),
                            boxShadow: !isPickup
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school_outlined,
                                size: 16.sp,
                                color: !isPickup
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFF64748B),
                              ),
                              6.width,
                              CommonText(
                                text: 'Drop-off Handover',
                                fontSize: 12.5,
                                fontWeight: !isPickup
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: !isPickup
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF64748B),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              16.height,

              /// 3. Photo Card
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  width: double.infinity,
                  height: 220.h,
                  color: const Color(0xFF0F172A),
                  child: Image.asset(
                    AppImages.pickupProofPhoto,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF1E293B),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          size: 48,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
