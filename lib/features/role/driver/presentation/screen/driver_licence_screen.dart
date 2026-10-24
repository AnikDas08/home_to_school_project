import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/presentation/controller/driver_registration_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverLicenceScreen extends StatelessWidget {
  const DriverLicenceScreen({super.key});

  /// Robust, responsive bottom sheet that works on all screen sizes with zero render overflow
  void _showOptionsPicker({
    required BuildContext context,
    required String title,
    required List<String> options,
    String? selectedValue,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final screenHeight = MediaQuery.of(context).size.height;
        // Bounded height guaranteed to fit all phone & tablet displays
        final sheetHeight = (screenHeight * 0.62).clamp(320.0, 560.0);

        return Container(
          height: sheetHeight,
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
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                12.height,

                /// Top Drag Handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),

                12.height,

                /// Header Row with Title and Close Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      10.width,
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
                ),

                12.height,
                const Divider(
                  color: Color(0xFFF1F5F9),
                  height: 1,
                  thickness: 1,
                ),

                /// Scrollable Options List
                Expanded(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    itemCount: options.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: Color(0xFFF8FAFC),
                      height: 1,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      final opt = options[index];
                      final isSelected = opt == selectedValue;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            onSelect(opt);
                            Navigator.pop(ctx);
                          },
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF1F5F9)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    opt,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? const Color(0xFF1B2B68)
                                          : const Color(0xFF0F172A),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                8.width,
                                if (isSelected)
                                  Icon(
                                    Icons.check_rounded,
                                    size: 20.sp,
                                    color: const Color(0xFF1B2B68),
                                  )
                                else
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
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Responsive upload box that safely handles long file names and text without overflowing
  Widget _buildUploadBox({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          constraints: BoxConstraints(minHeight: 64.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF93C5FD)
                  : const Color(0xFFE2E8F0),
              width: isSelected ? 1.2 : 1.0,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 10.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFEFF6FF)
                      : const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.file_upload_outlined,
                  size: 20.sp,
                  color: isSelected
                      ? const Color(0xFF1B2B68)
                      : const Color(0xFF475569),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    3.height,
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF94A3B8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              if (isSelected) ...[
                8.width,
                Icon(
                  Icons.check_circle_rounded,
                  size: 20.sp,
                  color: const Color(0xFF10B981),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverRegistrationController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
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
          text: "Driver's Licence",
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
        child: GetBuilder<DriverRegistrationController>(
          builder: (_) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. "Not Submitted" Pill Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const CommonText(
                      text: 'Not Submitted',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),

                  14.height,

                  /// 2. Licence Number Field
                  const CommonText(
                    text: 'Licence number',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  Container(
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
                          Icons.tag_rounded,
                          size: 18.sp,
                          color: const Color(0xFF64748B),
                        ),
                        10.width,
                        Expanded(
                          child: TextField(
                            controller: controller.licenceNumberController,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF0F172A),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              hintText: 'A8472-19305-66120',
                              hintStyle: TextStyle(
                                fontSize: 13.5.sp,
                                color: const Color(0xFF9CA3AF),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  14.height,

                  /// 3. Licence Class Field
                  const CommonText(
                    text: 'Licence class',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  GestureDetector(
                    onTap: () => _showOptionsPicker(
                      context: context,
                      title: 'Select Licence Class',
                      options: controller.licenceClasses,
                      selectedValue: controller.licenceClass,
                      onSelect: controller.setLicenceClass,
                    ),
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
                          Expanded(
                            child: Text(
                              controller.licenceClass ?? 'Select licence class',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w500,
                                color: controller.licenceClass != null
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF9CA3AF),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),

                  14.height,

                  /// 4. Issuing Province Field
                  const CommonText(
                    text: 'Issuing province',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  GestureDetector(
                    onTap: () => _showOptionsPicker(
                      context: context,
                      title: 'Select Issuing Province',
                      options: controller.provinces,
                      selectedValue: controller.issuingProvince,
                      onSelect: controller.setIssuingProvince,
                    ),
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
                          Expanded(
                            child: Text(
                              controller.issuingProvince ??
                                  'Select issuing province',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w500,
                                color: controller.issuingProvince != null
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF9CA3AF),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),

                  14.height,

                  /// 5. Expiry Date Field
                  const CommonText(
                    text: 'Expiry date',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: controller.expiryDate ??
                            DateTime.now().add(const Duration(days: 365)),
                        firstDate: DateTime.now(),
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
                        controller.setExpiryDate(picked);
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
                            size: 18.sp,
                            color: const Color(0xFF64748B),
                          ),
                          10.width,
                          Expanded(
                            child: Text(
                              controller.expiryDate != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(controller.expiryDate!)
                                  : 'Select expiry date',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w500,
                                color: controller.expiryDate != null
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
                  ),

                  14.height,

                  /// 6. Front of Licence Upload Box (Responsive & Overflow-safe)
                  const CommonText(
                    text: 'Front of licence',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  _buildUploadBox(
                    title: controller.frontLicenceFileName ?? 'No file yet',
                    subtitle: 'Colour photo of the front',
                    isSelected: controller.frontLicenceFileName != null,
                    onTap: controller.pickFrontLicence,
                  ),

                  14.height,

                  /// 7. Back of Licence Upload Box (Responsive & Overflow-safe)
                  const CommonText(
                    text: 'Back of licence',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  _buildUploadBox(
                    title: controller.backLicenceFileName ?? 'No file yet',
                    subtitle: 'Colour photo of the back',
                    isSelected: controller.backLicenceFileName != null,
                    onTap: controller.pickBackLicence,
                  ),

                  24.height,

                  /// 8. Submit Button
                  GestureDetector(
                    onTap: controller.submitLicence,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B68),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1B2B68).withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const CommonText(
                        text: 'Submit',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  20.height,
                ],
              ),
            );
          },
        ),
      ),
    ),
    );
  }
}
