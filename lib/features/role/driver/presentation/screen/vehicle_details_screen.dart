import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

                  /// 5. Vehicle Photos Section (Minimum 4 required)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonText(
                            text: 'Vehicle photos',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                          2.height,
                          const CommonText(
                            text: '4 required exterior photos',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64748B),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: controller.hasAllVehiclePhotos
                              ? const Color(0xFFECFDF5)
                              : const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: controller.hasAllVehiclePhotos
                                ? const Color(0xFFA7F3D0)
                                : const Color(0xFFBFDBFE),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              controller.hasAllVehiclePhotos
                                  ? Icons.check_circle_rounded
                                  : Icons.photo_camera_outlined,
                              size: 12.sp,
                              color: controller.hasAllVehiclePhotos
                                  ? const Color(0xFF059669)
                                  : const Color(0xFF1B2B68),
                            ),
                            4.width,
                            Text(
                              controller.hasAllVehiclePhotos
                                  ? '✓ 4/4 Completed'
                                  : '${controller.uploadedVehiclePhotosCount}/4 Required',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: controller.hasAllVehiclePhotos
                                    ? const Color(0xFF059669)
                                    : const Color(0xFF1B2B68),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  12.height,

                  /// 2x2 Grid for Front, Back, Left, Right
                  Row(
                    children: [
                      Expanded(
                        child: _buildVehicleAngleCard(
                          context: context,
                          controller: controller,
                          angle: 'front',
                          title: 'Front side',
                          subtitle: 'Front & plate',
                          icon: Icons.directions_car_rounded,
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: _buildVehicleAngleCard(
                          context: context,
                          controller: controller,
                          angle: 'back',
                          title: 'Back side',
                          subtitle: 'Rear & plate',
                          icon: Icons.directions_car_outlined,
                        ),
                      ),
                    ],
                  ),

                  10.height,

                  Row(
                    children: [
                      Expanded(
                        child: _buildVehicleAngleCard(
                          context: context,
                          controller: controller,
                          angle: 'left',
                          title: 'Left side',
                          subtitle: 'Left profile',
                          icon: Icons.space_dashboard_outlined,
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: _buildVehicleAngleCard(
                          context: context,
                          controller: controller,
                          angle: 'right',
                          title: 'Right side',
                          subtitle: 'Right profile',
                          icon: Icons.space_dashboard_outlined,
                        ),
                      ),
                    ],
                  ),

                  12.height,

                  /// Helpful instructions box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 15.sp,
                          color: const Color(0xFF1B2B68),
                        ),
                        8.width,
                        Expanded(
                          child: Text(
                            'Please upload all 4 sides (Front, Back, Left, Right). Ensure the vehicle is well-lit and license plates are legible.',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF475569),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  18.height,

                  /// Optional Additional Photos Section (Not required)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CommonText(
                                text: 'Additional photos',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                              6.width,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: const CommonText(
                                  text: 'Optional',
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          2.height,
                          const CommonText(
                            text: 'Not required • Interior, seats, or trunk (if any)',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64748B),
                          ),
                        ],
                      ),
                      if (controller.additionalVehiclePhotos.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: CommonText(
                            text: '${controller.additionalVehiclePhotos.length} Added',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1B2B68),
                          ),
                        ),
                    ],
                  ),

                  10.height,

                  /// Additional photos horizontal list
                  _buildAdditionalPhotosSection(context, controller),

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

  /// Interactive Card for one of the 4 vehicle angles
  Widget _buildVehicleAngleCard({
    required BuildContext context,
    required DriverRegistrationController controller,
    required String angle,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final File? photoFile = controller.getPhotoForAngle(angle);
    final hasPhoto = controller.hasPhotoForAngle(angle);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPhotoSourceBottomSheet(
          context: context,
          controller: controller,
          angle: angle,
          title: title,
        ),
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          height: 126.h,
          decoration: BoxDecoration(
            color: hasPhoto ? Colors.white : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: hasPhoto
                  ? const Color(0xFF38BDF8)
                  : const Color(0xFFE2E8F0),
              width: hasPhoto ? 1.5 : 1.0,
            ),
            boxShadow: hasPhoto
                ? [
                    BoxShadow(
                      color: const Color(0xFF38BDF8).withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (photoFile != null)
                  Image.file(
                    photoFile,
                    fit: BoxFit.cover,
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
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
                        6.height,
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        2.height,
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 10.5.sp,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.height,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 10.sp,
                                color: const Color(0xFF1B2B68),
                              ),
                              3.width,
                              Text(
                                'Add photo',
                                style: TextStyle(
                                  fontSize: 9.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1B2B68),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                /// When photo uploaded: Dark gradient overlay with angle name
                if (hasPhoto) ...[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.0),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14.sp,
                            color: const Color(0xFF34D399),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Top Right Edit Indicator
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.edit_rounded,
                        size: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom sheet picker to upload/retake/remove photo for an angle
  void _showPhotoSourceBottomSheet({
    required BuildContext context,
    required DriverRegistrationController controller,
    required String angle,
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final hasPhoto = controller.hasPhotoForAngle(angle);

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
                            'Upload $title Photo',
                            style: TextStyle(
                              fontSize: 16.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          3.height,
                          Text(
                            'Take a new photo or select from gallery',
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
                  subtitle: 'Use camera to capture $title',
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.pickVehicleAnglePhoto(
                      angle: angle,
                      source: ImageSource.camera,
                    );
                  },
                ),

                10.height,

                /// 2. Gallery Option
                _buildSourceOptionTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select from photos library',
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.pickVehicleAnglePhoto(
                      angle: angle,
                      source: ImageSource.gallery,
                    );
                  },
                ),

                if (hasPhoto) ...[
                  10.height,

                  /// 3. Remove Option
                  _buildSourceOptionTile(
                    icon: Icons.delete_outline_rounded,
                    iconColor: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    title: 'Remove Photo',
                    subtitle: 'Clear current $title photo',
                    onTap: () {
                      Navigator.pop(ctx);
                      controller.removeVehicleAnglePhoto(angle);
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

  /// Horizontal list showing uploaded additional photos and an "+ Add photo" card
  Widget _buildAdditionalPhotosSection(
    BuildContext context,
    DriverRegistrationController controller,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          /// Display uploaded additional photos with delete buttons
          ...List.generate(controller.additionalVehiclePhotos.length, (index) {
            final photoFile = controller.additionalVehiclePhotos[index];
            return Padding(
              padding: EdgeInsets.only(right: 12.w, top: 4.h, bottom: 4.h),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 86.w,
                    height: 86.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF93C5FD),
                        width: 1.2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11.r),
                      child: Image.file(
                        photoFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  /// Delete button at top right
                  Positioned(
                    top: -5.h,
                    right: -5.w,
                    child: GestureDetector(
                      onTap: () => controller.removeAdditionalVehiclePhoto(index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 22.w,
                        height: 22.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close_rounded,
                          size: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          /// "+ Add more" card
          GestureDetector(
            onTap: () => _showAdditionalPhotoBottomSheet(
              context: context,
              controller: controller,
            ),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 86.w,
              height: 86.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 1.2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      Icons.add_a_photo_outlined,
                      size: 16.sp,
                      color: const Color(0xFF1B2B68),
                    ),
                  ),
                  4.height,
                  Text(
                    '+ Add extra',
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1B2B68),
                    ),
                  ),
                  2.height,
                  Text(
                    '(Optional)',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom sheet to pick an additional photo (Camera or Gallery)
  void _showAdditionalPhotoBottomSheet({
    required BuildContext context,
    required DriverRegistrationController controller,
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
                            'Add Additional Photo',
                            style: TextStyle(
                              fontSize: 16.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          3.height,
                          Text(
                            'Interior, passenger seats, child booster, or trunk',
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
                  subtitle: 'Use camera to capture interior / extra angle',
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.addAdditionalVehiclePhoto(ImageSource.camera);
                  },
                ),

                10.height,

                /// 2. Gallery Option
                _buildSourceOptionTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select from photos library',
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.addAdditionalVehiclePhoto(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
