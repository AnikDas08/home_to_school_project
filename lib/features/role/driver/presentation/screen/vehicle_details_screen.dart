import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/presentation/controller/driver_registration_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  /// Responsive, scrollable vehicle type picker that works reliably on all devices
  void _showVehicleTypePicker(
    BuildContext context,
    DriverRegistrationController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = (screenHeight * 0.55).clamp(300.0, 480.0);

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

                /// Drag handle
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

                /// Header Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select Vehicle Type',
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

                /// Options List
                Expanded(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    itemCount: controller.vehicleTypes.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: Color(0xFFF8FAFC),
                      height: 1,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      final type = controller.vehicleTypes[index];
                      final isSelected = controller.vehicleType == type;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            controller.setVehicleType(type);
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
                                    type,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? const Color(0xFF1B2B68)
                                          : const Color(0xFF0F172A),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_rounded,
                                    size: 20.sp,
                                    color: const Color(0xFF1B2B68),
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverRegistrationController>();

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
          text: 'Vehicle Details',
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. Vehicle Type Dropdown
                  GestureDetector(
                    onTap: () => _showVehicleTypePicker(context, controller),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.vehicleType,
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
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

                  12.height,

                  /// 2. Row 1: Make & Model
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: controller.makeController,
                          hintText: 'Make (e.g. Toyota)',
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: _buildInputField(
                          controller: controller.modelController,
                          hintText: 'Model (e.g. Sienna)',
                        ),
                      ),
                    ],
                  ),

                  10.height,

                  /// 3. Row 2: Year & Colour
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: controller.yearController,
                          hintText: 'Year (e.g. 2023)',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: _buildInputField(
                          controller: controller.colourController,
                          hintText: 'Colour (Silver)',
                        ),
                      ),
                    ],
                  ),

                  10.height,

                  /// 4. Row 3: Plate & Passenger/Seats count
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: controller.plateController,
                          hintText: 'Plate (SCH-4091)',
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: _buildInputField(
                          controller: controller.seatsController,
                          hintText: '1',
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  18.height,

                  /// 5. Vehicle Photo Section
                  const CommonText(
                    text: 'Vehicle photo',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),

                  10.height,

                  /// Upload Container
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.pickVehiclePhoto,
                      borderRadius: BorderRadius.circular(14.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: controller.vehiclePhotoFileName != null
                                ? const Color(0xFF93C5FD)
                                : const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Camera Icon Circle
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: controller.vehiclePhotoFileName != null
                                    ? const Color(0xFFEFF6FF)
                                    : const Color(0xFFEFF6FF),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                controller.vehiclePhotoFileName != null
                                    ? Icons.check_circle_rounded
                                    : Icons.camera_alt_outlined,
                                size: 22.sp,
                                color: controller.vehiclePhotoFileName != null
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFF1B2B68),
                              ),
                            ),

                            12.height,

                            /// Upload Text
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                controller.vehiclePhotoFileName ??
                                    'Upload Vehicle Photo',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            4.height,

                            const CommonText(
                              text: 'Take photo or choose JPG/PNG of exterior',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  24.height,

                  /// 6. Continue Button
                  GestureDetector(
                    onTap: controller.submitVehicleDetails,
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
                        text: 'Continue',
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextAlign textAlign = TextAlign.start,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        textAlign: textAlign,
        keyboardType: keyboardType,
        maxLines: 1,
        style: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFF0F172A),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12.5.sp,
            color: const Color(0xFF9CA3AF),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
