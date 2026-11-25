import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/student/presentation/controller/student_verification_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentIdVerificationScreen extends StatelessWidget {
  const StudentIdVerificationScreen({super.key});

  /// Section Card Wrapper
  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: const Color(0xFF1B2B68),
                ),
              ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    2.height,
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.height,
          child,
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isReadOnly = false,
  }) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: isReadOnly ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: isReadOnly ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
          10.width,
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: isReadOnly,
              enabled: !isReadOnly,
              style: TextStyle(
                fontSize: 13.5.sp,
                color: isReadOnly ? const Color(0xFF475569) : const Color(0xFF0F172A),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          if (isReadOnly)
            Icon(
              Icons.lock_outline_rounded,
              size: 16.sp,
              color: const Color(0xFF94A3B8),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentVerificationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

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
        title: CommonText(
          text: controller.isReadOnly ? 'Student ID' : 'Student Verification',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
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
        child: GetBuilder<StudentVerificationController>(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. Centered Header
                  Center(
                    child: Column(
                      children: [
                        CommonText(
                          text: controller.isReadOnly
                              ? 'Student ID & Enrollment'
                              : 'Verify Student Identity (18+)',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                          textAlign: TextAlign.center,
                        ),
                        6.height,
                        CommonText(
                          text: controller.isReadOnly
                              ? 'Official student identification verified for transport services.'
                              : 'Enter your school or college enrollment details to verify your student status.',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),

                  if (controller.isReadOnly) ...[
                    14.height,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 16.sp,
                            color: const Color(0xFF64748B),
                          ),
                          8.width,
                          Expanded(
                            child: Text(
                              'Submitted student identification is locked and cannot be edited. It can only be viewed.',
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                color: const Color(0xFF475569),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  20.height,

                  /// 2. Student Enrollment Details
                  _buildSectionCard(
                    icon: Icons.school_outlined,
                    title: 'Institution & Student Details',
                    subtitle: 'College, university, or high school info',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: 'School / College / University Name',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildInputField(
                          controller: controller.institutionController,
                          hintText: 'e.g. University of Toronto / Seneca College',
                          icon: Icons.account_balance_outlined,
                          isReadOnly: controller.isReadOnly,
                        ),

                        12.height,

                        const CommonText(
                          text: 'Student ID / Registration Number',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildInputField(
                          controller: controller.studentIdController,
                          hintText: 'e.g. STU-992184',
                          icon: Icons.tag_rounded,
                          isReadOnly: controller.isReadOnly,
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// 3. Security & Encryption Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 16.sp,
                          color: const Color(0xFF64748B),
                        ),
                        8.width,
                        Expanded(
                          child: Text(
                            'All details are encrypted. Your student identity will be reviewed within 24 hours by our safety team.',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              color: const Color(0xFF475569),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  24.height,

                  if (controller.isReadOnly) ...[
                    /// Read-Only Status Bar (Non-Editable)
                    Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            size: 18.sp,
                            color: const Color(0xFF10B981),
                          ),
                          8.width,
                          const CommonText(
                            text: 'Verified • Read-Only (Cannot Edit)',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    /// 4. Submit & Finish Button (Only during initial registration)
                    GestureDetector(
                      onTap: controller.submitVerification,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 48.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B2B68),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1B2B68).withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const CommonText(
                          text: 'Submit & Finish',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],

                  20.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
