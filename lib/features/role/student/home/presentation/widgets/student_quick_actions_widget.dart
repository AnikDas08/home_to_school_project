import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentQuickActionsWidget extends StatelessWidget {
  final VoidCallback? onBookRide;
  final VoidCallback? onStudentId;
  final VoidCallback? onSafetyHelp;

  const StudentQuickActionsWidget({
    super.key,
    this.onBookRide,
    this.onStudentId,
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

        /// 1. Primary Action Button: New Booking
        GestureDetector(
          onTap: onBookRide ?? () => Get.toNamed(AppRoutes.studentBookRide),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B2B68).withValues(alpha: 0.2),
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

        /// 2. Row of Secondary Action Cards: Student ID & Safety & SOS (no description text)
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Action 1: Student ID
              Expanded(
                child: _buildSecondaryCard(
                  icon: Icons.school_outlined,
                  iconColor: const Color(0xFF3B82F6),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Student ID',
                  onTap: onStudentId ??
                      () => Get.toNamed(AppRoutes.studentIdVerification),
                ),
              ),

              12.width,

              /// Action 2: Safety & SOS
              Expanded(
                child: _buildSecondaryCard(
                  icon: Icons.shield_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  bgColor: const Color(0xFFFFF7ED),
                  title: 'Safety & SOS',
                  onTap: onSafetyHelp ??
                      () => Get.toNamed(AppRoutes.emergencyContacts),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22.sp,
                color: iconColor,
              ),
            ),
            10.height,
            CommonText(
              text: title,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
