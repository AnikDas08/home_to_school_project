import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/controller/walkshare_active_walk_controller.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/widgets/walkshare_active_walk_info_card.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/widgets/walkshare_slide_to_confirm_button.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareActiveWalkScreen extends StatelessWidget {
  const WalkshareActiveWalkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareActiveWalkController());
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          /// 1. Map Image Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 280.h,
            child: Image.asset(
              AppImages.mapImageShow,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE2E8F0),
                child: const Center(
                  child: Icon(
                    Icons.map_rounded,
                    size: 64,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
            ),
          ),

          /// 2. Live GPS Badge (Bottom-left above bottom sheet)
          Positioned(
            left: 16.w,
            bottom: 300.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.92),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.width,
                  Text(
                    'Live GPS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 3. Blue Circular Compass / Recenter Button (Bottom-right above bottom sheet)
          Positioned(
            right: 16.w,
            bottom: 300.h,
            child: GestureDetector(
              onTap: controller.onRecenterMap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1D4ED8).withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Icon(
                      Icons.navigation_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// 4. Top Header: Back Button, "Active trip", SOS Button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8.h,
                bottom: 12.h,
                left: 16.w,
                right: 16.w,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.95),
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Back Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: 26,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),

                  /// Title
                  const CommonText(
                    text: 'Active trip',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),

                  /// SOS Button
                  GestureDetector(
                    onTap: controller.onSosTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEF4444).withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: Colors.white,
                            size: 14.sp,
                          ),
                          4.width,
                          Text(
                            'SOS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 5. Bottom Card Container
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                16.w,
                16.h,
                16.w,
                bottomPadding > 0 ? bottomPadding + 8.h : 20.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Trip Info Card
                    WalkshareActiveWalkInfoCard(
                      status: controller.tripStatus.value,
                      time: controller.tripTime.value,
                      address: controller.pickupAddress.value,
                      childrenNames: controller.riders.value,
                    ),

                    16.height,

                    /// Dynamic Action Button Area
                    if (!controller.isArrived.value) ...[
                      /// State 1: Slide to confirm arrival
                      WalkshareSlideToConfirmButton(
                        onConfirmed: controller.onSlideConfirmed,
                        text: 'Slide to confirm arrival',
                      ),
                    ] else if (!controller.isPickedUp.value) ...[
                      /// State 2: Confirm child pickup
                      GestureDetector(
                        onTap: controller.onConfirmPickup,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 52.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B2B68),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF1B2B68).withOpacity(0.25),
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
                                Icons.person_add_alt_1_rounded,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                              10.width,
                              const CommonText(
                                text: 'Confirm child pickup',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      /// State 3: Confirm drop-off & Message parent
                      GestureDetector(
                        onTap: controller.onConfirmDropOff,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B2B68),
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF1B2B68).withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const CommonText(
                            text: 'Confirm drop-off',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      10.height,

                      GestureDetector(
                        onTap: controller.onMessageParent,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const CommonText(
                            text: 'Message parent',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
