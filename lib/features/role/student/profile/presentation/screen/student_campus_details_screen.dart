import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentCampusDetailsScreen extends StatelessWidget {
  const StudentCampusDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: Color(0xFF0F172A),
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Campus & Enrollment',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body Content
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Verified Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.greenCheck,
                      width: 22.sp,
                      height: 22.sp,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.verified_rounded,
                        size: 22.sp,
                        color: const Color(0xFF22C55E),
                      ),
                    ),
                    12.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonText(
                            text: 'Enrolled & Verified Student',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E3A8A),
                          ),
                          3.height,
                          Text(
                            'Your academic status is verified with Seneca College for the 2026-2027 academic year.',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              color: const Color(0xFF475569),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              20.height,

              /// Institution Details Card
              _buildSectionCard(
                title: 'Institution Details',
                children: [
                  _buildDetailRow(
                    label: 'Institution',
                    value: 'Seneca College',
                    icon: Icons.account_balance_rounded,
                  ),
                  _buildDetailRow(
                    label: 'Campus',
                    value: 'Newnham Campus',
                    icon: Icons.location_city_rounded,
                  ),
                  _buildDetailRow(
                    label: 'Campus Address',
                    value: '1750 Finch Ave E, Toronto, ON M2J 2X5',
                    icon: Icons.pin_drop_outlined,
                  ),
                  _buildDetailRow(
                    label: 'Program of Study',
                    value: 'Computer Programming & Analysis',
                    icon: Icons.menu_book_rounded,
                  ),
                  _buildDetailRow(
                    label: 'Enrollment Status',
                    value: 'Full-Time (Active)',
                    icon: Icons.check_circle_outline_rounded,
                    isHighlight: true,
                  ),
                ],
              ),

              16.height,

              /// Student ID & Credentials Card
              _buildSectionCard(
                title: 'Student Credentials',
                children: [
                  _buildDetailRow(
                    label: 'Student ID Number',
                    value: 'STU-992184',
                    icon: Icons.badge_outlined,
                  ),
                  _buildDetailRow(
                    label: 'Campus Card Expiry',
                    value: 'August 31, 2027',
                    icon: Icons.calendar_today_outlined,
                  ),
                  _buildDetailRow(
                    label: 'Verification Level',
                    value: 'Level 2 (Government & College ID)',
                    icon: Icons.verified_user_outlined,
                  ),
                ],
              ),

              20.height,

              /// Button to view Verified Student ID
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.studentIdVerification),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2B68),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B2B68).withValues(alpha: 0.22),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card_rounded, color: Colors.white, size: 18.sp),
                      8.width,
                      const CommonText(
                        text: 'View Uploaded Student ID Card',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              20.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
          12.height,
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
    bool isHighlight = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: const Color(0xFF64748B)),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                2.height,
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
                    color: isHighlight ? const Color(0xFF10B981) : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

