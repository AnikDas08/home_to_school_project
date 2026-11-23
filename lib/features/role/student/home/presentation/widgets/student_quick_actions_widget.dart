import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentQuickActionsWidget extends StatelessWidget {
  final VoidCallback? onBookRide;
  final VoidCallback? onWalkShare;
  final VoidCallback? onStudentId;
  final VoidCallback? onSafetyHelp;

  const StudentQuickActionsWidget({
    super.key,
    this.onBookRide,
    this.onWalkShare,
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

        /// 1. Primary Action Button: Book a Ride
        GestureDetector(
          onTap: onBookRide ?? () => Get.toNamed(AppRoutes.studentBookRide),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 52.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B2B68).withValues(alpha: 0.22),
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
                  Icons.directions_car_filled_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
                10.width,
                const CommonText(
                  text: 'Book a Ride to Campus',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

        12.height,

        /// 2. Row of 3 Secondary Action Cards: WalkShare, Student ID, Safety & Help
        Row(
          children: [
            /// Action 1: Campus WalkShare
            Expanded(
              child: _buildSecondaryCard(
                icon: Icons.directions_walk_rounded,
                iconColor: const Color(0xFF10B981),
                bgColor: const Color(0xFFECFDF5),
                title: 'WalkShare',
                subtitle: 'Group walk',
                onTap: onWalkShare ??
                    () => Get.toNamed(
                          AppRoutes.studentBookRide,
                          arguments: {'isWalkShare': true},
                        ),
              ),
            ),

            10.width,

            /// Action 2: Student ID
            Expanded(
              child: _buildSecondaryCard(
                icon: Icons.badge_outlined,
                iconColor: const Color(0xFF1B2B68),
                bgColor: const Color(0xFFEFF6FF),
                title: 'Student ID',
                subtitle: 'Verified',
                badgeText: '✓',
                onTap: onStudentId ??
                    () => Get.toNamed(AppRoutes.studentIdVerification),
              ),
            ),

            10.width,

            /// Action 3: Safety & Help
            Expanded(
              child: _buildSecondaryCard(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFFF59E0B),
                bgColor: const Color(0xFFFFFBEB),
                title: 'Safety & SOS',
                subtitle: 'Emergency',
                onTap: onSafetyHelp ??
                    () => Get.toNamed(AppRoutes.emergencyContacts),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    String? badgeText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 106.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.1,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 20.sp,
                color: iconColor,
              ),
            ),
            8.height,
            CommonText(
              text: title,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            2.height,
            CommonText(
              text: subtitle,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

