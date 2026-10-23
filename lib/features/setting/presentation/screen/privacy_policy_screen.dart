import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const CommonText(
          text: AppString.privacyPolicy,
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
              text: 'Privacy Policy for Home to School',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            8.height,
            CommonText(
              text: 'Last updated: October 2026',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            16.height,
            _buildSection(
              '1. Information We Collect',
              'We collect personal information necessary for student transit management, including parent and student contact details, pickup and drop-off addresses, live GPS bus location data, and communication records between parents, drivers, and school coordinators.',
            ),
            _buildSection(
              '2. How We Use Information',
              'The collected data is exclusively used to provide real-time bus tracking, send arrival notifications, ensure passenger safety, and coordinate transport schedules between schools and guardians.',
            ),
            _buildSection(
              '3. Location Data & Child Safety',
              'Real-time GPS location is actively tracked during scheduled transit hours to guarantee child safety and ETA accuracy. Location information is strictly encrypted and accessible only to verified parents, authorized drivers, and school administrators.',
            ),
            _buildSection(
              '4. Data Security & Storage',
              'We implement standard encryption, secure socket layers, and restricted access protocols to safeguard all sensitive records from unauthorized access.',
            ),
            _buildSection(
              '5. Contact Us',
              'For questions regarding privacy practices, please contact your school administrator or email support@hometoschool.app.',
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
