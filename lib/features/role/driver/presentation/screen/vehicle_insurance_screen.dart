import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/presentation/controller/driver_registration_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class VehicleInsuranceScreen extends StatelessWidget {
  const VehicleInsuranceScreen({super.key});

  /// Bottom sheet to choose Camera or Gallery for document upload
  void _showDocumentSourcePicker({
    required BuildContext context,
    required String title,
    required String subtitle,
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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          3.height,
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      behavior: HitTestBehavior.opaque,
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
                _buildSourceOptionTile(
                  icon: Icons.camera_alt_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                  title: 'Take a Photo',
                  subtitle: 'Use camera to capture document',
                  onTap: () {
                    Navigator.pop(ctx);
                    onPick(ImageSource.camera);
                  },
                ),

                10.height,

                /// 2. Gallery Option
                _buildSourceOptionTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select PDF, JPG or PNG scan',
                  onTap: () {
                    Navigator.pop(ctx);
                    onPick(ImageSource.gallery);
                  },
                ),

                if (hasFile) ...[
                  10.height,

                  /// 3. Remove Option
                  _buildSourceOptionTile(
                    icon: Icons.delete_outline_rounded,
                    iconColor: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    title: 'Remove Document',
                    subtitle: 'Clear this document',
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

  Widget _buildSourceOptionTile({
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

  /// Single document upload card with thumbnail preview and change/remove options
  Widget _buildDocumentUploadCard({
    required String title,
    required String subtitle,
    required File? file,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    final hasFile = file != null || fileName != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: hasFile ? Colors.white : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: hasFile
                  ? const Color(0xFF93C5FD)
                  : const Color(0xFFE2E8F0),
              width: hasFile ? 1.3 : 1.0,
            ),
            boxShadow: hasFile
                ? const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              if (file != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    file,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: hasFile
                        ? const Color(0xFFEFF6FF)
                        : const Color(0xFFEFF6FF),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    hasFile
                        ? Icons.description_rounded
                        : Icons.camera_alt_outlined,
                    size: 20.sp,
                    color: hasFile
                        ? const Color(0xFF1B2B68)
                        : const Color(0xFF1B2B68),
                  ),
                ),

              12.width,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName ?? title,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    3.height,
                    Text(
                      hasFile ? 'Tap to change or remove' : subtitle,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: hasFile
                            ? const Color(0xFF10B981)
                            : const Color(0xFF64748B),
                        fontWeight: hasFile ? FontWeight.w600 : FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Icon(
                hasFile
                    ? Icons.check_circle_rounded
                    : Icons.add_circle_outline_rounded,
                size: 20.sp,
                color: hasFile
                    ? const Color(0xFF10B981)
                    : const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Card Wrapper
  Widget _buildSectionContainer({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
    bool isRequired = true,
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
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 16.sp,
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
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (isRequired)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1B2B68),
                    ),
                  ),
                ),
            ],
          ),
          14.height,
          child,
        ],
      ),
    );
  }

  /// Input text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: const Color(0xFF64748B),
          ),
          10.width,
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 1,
              style: TextStyle(
                fontSize: 13.5.sp,
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Date picker selector container
  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onPicked,
    DateTime? firstDate,
  }) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now().add(const Duration(days: 365)),
          firstDate: firstDate ?? DateTime(2020),
          lastDate: DateTime(2040),
          builder: (ctx, child) {
            return Theme(
              data: Theme.of(ctx).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF1B2B68),
                  onPrimary: Colors.white,
                  onSurface: Color(0xFF0F172A),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onPicked(picked);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 17.sp,
              color: const Color(0xFF64748B),
            ),
            10.width,
            Expanded(
              child: Text(
                selectedDate != null
                    ? DateFormat('MMMM dd, yyyy').format(selectedDate)
                    : label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: selectedDate != null
                      ? const Color(0xFF0F172A)
                      : const Color(0xFF9CA3AF),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverRegistrationController>(
      builder: (controller) {
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
            title: const CommonText(
              text: 'Insurance & Documents',
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Stepper / Status Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Step 3 of 3 • Safety & Compliance',
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1B2B68),
                          ),
                        ),
                      ),
                      Text(
                        'Final step',
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),

                  14.height,

                  /// ==========================================
                  /// 1. VEHICLE INSURANCE SECTION
                  /// ==========================================
                  _buildSectionContainer(
                    icon: Icons.shield_outlined,
                    title: 'Vehicle Insurance',
                    subtitle: 'Valid commercial / rideshare student coverage',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Insurance Policy Number
                        const CommonText(
                          text: 'Insurance policy number',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildTextField(
                          controller: controller.insuranceNumberController,
                          hintText: 'e.g. POL-992184-CA',
                          icon: Icons.tag_rounded,
                        ),

                        12.height,

                        /// Insurance Provider (Optional / Recommended)
                        const CommonText(
                          text: 'Insurance company (optional)',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildTextField(
                          controller: controller.insuranceProviderController,
                          hintText: 'e.g. Intact Insurance, Aviva',
                          icon: Icons.business_outlined,
                        ),

                        12.height,

                        /// Insurance Expiry Date
                        const CommonText(
                          text: 'Insurance expiry date',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildDatePickerField(
                          context: context,
                          label: 'Select insurance expiry date',
                          selectedDate: controller.insuranceExpiryDate,
                          onPicked: controller.setInsuranceExpiryDate,
                          firstDate: DateTime.now(),
                        ),

                        12.height,

                        /// Insurance Document Image
                        const CommonText(
                          text: 'Insurance certificate / pink slip',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildDocumentUploadCard(
                          title: 'Upload Insurance Card / Policy',
                          subtitle: 'Colour photo of pink slip or policy page',
                          file: controller.insuranceDocumentPhoto,
                          fileName: controller.insuranceDocumentFileName,
                          onTap: () => _showDocumentSourcePicker(
                            context: context,
                            title: 'Vehicle Insurance Document',
                            subtitle: 'Upload photo of current insurance policy',
                            hasFile: controller.insuranceDocumentPhoto != null ||
                                controller.insuranceDocumentFileName != null,
                            onPick: controller.pickInsuranceDocument,
                            onRemove: controller.removeInsuranceDocument,
                          ),
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// ==========================================
                  /// 2. VULNERABLE SECTOR CHECK (VSC)
                  /// ==========================================
                  _buildSectionContainer(
                    icon: Icons.verified_user_outlined,
                    title: 'Vulnerable Sector Check',
                    subtitle: 'Police background clearance for student transport',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Vulnerability Date (Issue or Expiry Date)
                        const CommonText(
                          text: 'VSC issue / clearance date',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildDatePickerField(
                          context: context,
                          label: 'Select clearance date',
                          selectedDate: controller.vulnerabilityDate,
                          onPicked: controller.setVulnerabilityDate,
                          firstDate: DateTime(2020),
                        ),

                        12.height,

                        /// Vulnerability Document Image
                        const CommonText(
                          text: 'VSC certificate document',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildDocumentUploadCard(
                          title: 'Upload VSC Police Document',
                          subtitle: 'Clear photo or scan of your police clearance',
                          file: controller.vulnerabilityDocumentPhoto,
                          fileName: controller.vulnerabilityDocumentFileName,
                          onTap: () => _showDocumentSourcePicker(
                            context: context,
                            title: 'Vulnerable Sector Clearance',
                            subtitle: 'Official police / background verification document',
                            hasFile: controller.vulnerabilityDocumentPhoto != null ||
                                controller.vulnerabilityDocumentFileName != null,
                            onPick: controller.pickVulnerabilityDocument,
                            onRemove: controller.removeVulnerabilityDocument,
                          ),
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// ==========================================
                  /// 3. VEHICLE REGISTRATION
                  /// ==========================================
                  _buildSectionContainer(
                    icon: Icons.directions_car_outlined,
                    title: 'Vehicle Registration',
                    subtitle: 'Official vehicle ownership permit',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Vehicle Registration Document Image
                        const CommonText(
                          text: 'Vehicle registration document image',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        6.height,
                        _buildDocumentUploadCard(
                          title: 'Upload Vehicle Registration Document',
                          subtitle: 'Photo of vehicle ownership / green slip',
                          file: controller.registrationDocumentPhoto,
                          fileName: controller.registrationDocumentFileName,
                          onTap: () => _showDocumentSourcePicker(
                            context: context,
                            title: 'Vehicle Registration Document',
                            subtitle: 'Upload photo of vehicle permit / registration',
                            hasFile: controller.registrationDocumentPhoto != null ||
                                controller.registrationDocumentFileName != null,
                            onPick: controller.pickRegistrationDocument,
                            onRemove: controller.removeRegistrationDocument,
                          ),
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// Security and encryption badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                            'All documents are securely encrypted. Your insurance and safety clearance will be verified by our safety team.',
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

                  /// Submit Button
                  GestureDetector(
                    onTap: controller.submitAllDocuments,
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
                        text: 'Submit Documents',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  24.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
