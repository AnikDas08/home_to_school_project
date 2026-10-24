import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianQuickActionsWidget extends StatelessWidget {
  final VoidCallback? onNewBooking;
  final VoidCallback? onMyChildren;
  final VoidCallback? onSafetyHelp;

  const GuardianQuickActionsWidget({
    super.key,
    this.onNewBooking,
    this.onMyChildren,
    this.onSafetyHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          text: 'Quick Actions',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
          textAlign: TextAlign.start,
        ),

        14.height,

        /// New Booking Primary Button
        GestureDetector(
          onTap: onNewBooking ?? () => Get.toNamed(AppRoutes.bookRide),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B2B68).withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_calendar_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                10.width,
                const CommonText(
                  text: 'New Booking',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

        14.height,

        /// Row with "My Children" and "Safety & Help"
        Row(
          children: [
            /// My Children Card
            Expanded(
              child: GestureDetector(
                onTap: onMyChildren ?? () => Get.toNamed(AppRoutes.myChildren),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFF6FF),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.people_alt_outlined,
                          color: const Color(0xFF3B82F6),
                          size: 22.sp,
                        ),
                      ),
                      10.height,
                      const CommonText(
                        text: 'My Children',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            12.width,

            /// Safety & Help Card
            Expanded(
              child: GestureDetector(
                onTap: onSafetyHelp ?? () => Get.toNamed(AppRoutes.contactSupport),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF7ED),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/safety_icon.svg',
                          width: 22.w,
                          height: 22.w,
                        ),
                      ),
                      10.height,
                      const CommonText(
                        text: 'Safety & Help',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
