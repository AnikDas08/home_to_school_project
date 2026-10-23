import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const CommonText(
          text: AppString.termsOfServices,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Terms of Service',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            8.height,
            CommonText(
              text: 'Effective date: October 2026',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            16.height,
            _buildSection(
              '1. Acceptance of Terms',
              'By using the Home to School application, you agree to comply with these terms, school transit rules, and all applicable child transportation safety regulations.',
            ),
            _buildSection(
              '2. Authorized Use',
              'Accounts are intended strictly for verified parents, guardians, approved school bus drivers, and school coordinators. Sharing account credentials with unauthorized third parties is strictly prohibited.',
            ),
            _buildSection(
              '3. Real-Time Tracking & Notifications',
              'While we strive for 100% accuracy in estimated arrival times and GPS tracking, transit schedules may fluctuate due to traffic conditions, weather events, or road detours.',
            ),
            _buildSection(
              '4. Conduct & Communication',
              'All messaging features must be used respectfully and solely for school transportation logistics, child pickup coordination, and emergency alerts.',
            ),
            _buildSection(
              '5. Modifications',
              'We reserve the right to amend these terms in coordination with participating schools to enhance safety guidelines and service quality.',
            ),
            24.height,
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          6.height,
          Text(
            content,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
