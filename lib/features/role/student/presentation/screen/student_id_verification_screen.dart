import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/student/presentation/controller/student_verification_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentIdVerificationScreen extends StatelessWidget {
  const StudentIdVerificationScreen({super.key});

  /// Modal bottom sheet to choose Camera or Gallery for photo upload
  void _showImageSourcePicker({
    required BuildContext context,
    required String title,
    required bool hasFile,
    required Function(ImageSource) onPick,
    required VoidCallback onRemove,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, -4),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close_rounded,
                          size: 16.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
                18.height,

                /// 1. Camera Option
                _buildSourceTile(
                  icon: Icons.camera_alt_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                  title: 'Take a Photo',
                  subtitle: 'Use camera to capture ID',
                  onTap: () {
                    Navigator.pop(ctx);
                    onPick(ImageSource.camera);
                  },
                ),

                10.height,

                /// 2. Gallery Option
                _buildSourceTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select from photo library',
                  onTap: () {
                    Navigator.pop(ctx);
                    onPick(ImageSource.gallery);
                  },
                ),

                if (hasFile) ...[
                  10.height,
                  _buildSourceTile(
                    icon: Icons.delete_outline_rounded,
                    iconColor: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    title: 'Remove Photo',
                    subtitle: 'Clear this uploaded photo',
                    onTap: () {
                      Navigator.pop(ctx);
                      onRemove();
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSourceTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 20.sp, color: iconColor),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.5.sp,
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
              Icon(
                Icons.chevron_right_rounded,
                size: 20.sp,
                color: const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ID Card Side Box (Front / Back)
  Widget _buildIdSideBox({
    required BuildContext context,
    required String label,
    required File? file,
    required String? fileName,
    required VoidCallback onTap,
    bool isReadOnly = false,
  }) {
    final hasImage = file != null || fileName != null;

    return GestureDetector(
      onTap: isReadOnly ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          color: hasImage ? Colors.white : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasImage ? const Color(0xFF93C5FD) : const Color(0xFFE2E8F0),
            width: hasImage ? 1.4 : 1.0,
          ),
          boxShadow: hasImage
              ? const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11.r),
          child: hasImage && file != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(file, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.w,
                      bottom: 8.h,
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14.sp,
                            color: const Color(0xFF34D399),
                          ),
                          6.width,
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isReadOnly)
                      Positioned(
                        right: 8.w,
                        top: 8.h,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit_rounded,
                            size: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (isReadOnly)
                      Positioned(
                        right: 8.w,
                        top: 8.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_rounded, size: 10.sp, color: Colors.white),
                              3.width,
                              Text(
                                'VERIFIED',
                                style: TextStyle(
                                  fontSize: 8.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              : isReadOnly
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          color: const Color(0xFFF8FAFC),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 38.w,
                                height: 38.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFF6FF),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.badge_outlined,
                                  size: 20.sp,
                                  color: const Color(0xFF1B2B68),
                                ),
                              ),
                              6.height,
                              Text(
                                '$label Side',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              2.height,
                              Text(
                                'Official Student ID',
                                style: TextStyle(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 8.w,
                          top: 8.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_rounded, size: 10.sp, color: Colors.white),
                                3.width,
                                Text(
                                  'VERIFIED',
                                  style: TextStyle(
                                    fontSize: 8.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF6FF),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 20.sp,
                            color: const Color(0xFF1B2B68),
                          ),
                        ),
                        8.height,
                        Text(
                          '$label Side',
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        3.height,
                        Text(
                          'Tap to upload',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

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
                              : 'Upload front and back photos of your valid student ID card to book rides for yourself.',
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

                  /// 2. Student ID Card (Both sides: Front & Back)
                  _buildSectionCard(
                    icon: Icons.badge_outlined,
                    title: 'Student ID Card (Front & Back)',
                    subtitle: controller.isReadOnly
                        ? 'Verified ID documents on file (Read-Only)'
                        : 'Both sides are required for enrollment verification',
                    child: Row(
                      children: [
                        /// Front Box
                        Expanded(
                          child: _buildIdSideBox(
                            context: context,
                            label: 'Front',
                            file: controller.idFrontPhoto,
                            fileName: controller.idFrontFileName,
                            isReadOnly: controller.isReadOnly,
                            onTap: () => _showImageSourcePicker(
                              context: context,
                              title: 'Student ID - Front Side',
                              hasFile: controller.idFrontPhoto != null ||
                                  controller.idFrontFileName != null,
                              onPick: controller.pickIdFront,
                              onRemove: controller.removeIdFront,
                            ),
                          ),
                        ),

                        12.width,

                        /// Back Box
                        Expanded(
                          child: _buildIdSideBox(
                            context: context,
                            label: 'Back',
                            file: controller.idBackPhoto,
                            fileName: controller.idBackFileName,
                            isReadOnly: controller.isReadOnly,
                            onTap: () => _showImageSourcePicker(
                              context: context,
                              title: 'Student ID - Back Side',
                              hasFile: controller.idBackPhoto != null ||
                                  controller.idBackFileName != null,
                              onPick: controller.pickIdBack,
                              onRemove: controller.removeIdBack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// 3. Student Enrollment Details
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

                  /// 4. Security & Encryption Badge
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
                            'All documents are encrypted. Your student identity will be reviewed within 24 hours by our safety team.',
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
                    /// 5. Submit & Finish Button (Only during initial registration)
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

