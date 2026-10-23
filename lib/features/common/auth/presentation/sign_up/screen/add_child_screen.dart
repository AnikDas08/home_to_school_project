import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/add_child_controller.dart';

class AddChildScreen extends StatelessWidget {
  const AddChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddChildController());

    return Scaffold(
      backgroundColor: Colors.white,
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),
      body: GetBuilder<AddChildController>(
        builder: (_) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  24.height,

                  /// Title
                  const CommonText(
                    text: 'Add Your Child',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                    textAlign: TextAlign.center,
                  ),

                  8.height,

                  /// Subtitle
                  const CommonText(
                    text: 'Set up school transportation for your child',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    textAlign: TextAlign.center,
                  ),

                  28.height,

                  /// Avatar with Dashed Circular Border
                  Center(
                    child: SizedBox(
                      width: 140.w,
                      height: 140.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          /// Outer Dashed Circle
                          CustomPaint(
                            size: Size(136.w, 136.w),
                            painter: _DashedCirclePainter(
                              color: const Color(0xFFCBD5E1),
                              strokeWidth: 1.5,
                              dashWidth: 5.0,
                              dashSpace: 4.0,
                            ),
                          ),

                          /// Inner Avatar Container
                          Container(
                            width: 116.w,
                            height: 116.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEEF2F6),
                            ),
                            alignment: Alignment.center,
                            child: controller.image != null
                                ? ClipOval(
                                    child: Image.file(
                                      File(controller.image!),
                                      width: 116.w,
                                      height: 116.w,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 52.sp,
                                    color: const Color(0xFF1E293B),
                                  ),
                          ),

                          /// Camera Badge Button
                          Positioned(
                            bottom: 6.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: controller.openGallery,
                              child: Container(
                                width: 34.w,
                                height: 34.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0A1931),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  12.height,

                  /// "You can change this later" Caption
                  const CommonText(
                    text: 'You can change this later',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    textAlign: TextAlign.center,
                  ),

                  28.height,

                  /// Input 1: Child's Full Name
                  _buildInputField(
                    controller: controller.nameController,
                    hintText: "Child's Full Name",
                    prefixIcon: Icons.person_outline_rounded,
                  ),

                  14.height,

                  /// Input 2: School Name
                  _buildInputField(
                    controller: controller.schoolController,
                    hintText: 'School Name',
                    prefixIcon: Icons.menu_book_outlined,
                  ),

                  14.height,

                  /// Input 3: Grade (with dropdown picker)
                  GestureDetector(
                    onTap: () => _showGradePicker(context, controller),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22.sp,
                            color: const Color(0xFF94A3B8),
                          ),
                          12.width,
                          Expanded(
                            child: CommonText(
                              text: controller.gradeController.text.isNotEmpty
                                  ? controller.gradeController.text
                                  : 'Grade',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: controller.gradeController.text.isNotEmpty
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFF94A3B8),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  28.height,

                  /// Save Button
                  CommonButton(
                    titleText: 'Save',
                    isLoading: controller.isLoading,
                    onTap: controller.saveChildInfo,
                  ),

                  40.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        style: GoogleFonts.roboto(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          icon: Icon(
            prefixIcon,
            size: 20.sp,
            color: const Color(0xFF94A3B8),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }

  void _showGradePicker(BuildContext context, AddChildController controller) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: 380.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                16.height,
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              16.height,
              const CommonText(
                text: 'Select Grade',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
              12.height,
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.gradeOptions.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFF8FAFC)),
                  itemBuilder: (context, index) {
                    final grade = controller.gradeOptions[index];
                    final isSelected =
                        controller.gradeController.text == grade;
                    return ListTile(
                      title: CommonText(
                        text: grade,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primaryColor
                            : const Color(0xFF0F172A),
                        textAlign: TextAlign.start,
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_rounded,
                              color: AppColors.primaryColor,
                            )
                          : null,
                      onTap: () {
                        controller.selectGrade(grade);
                        Navigator.pop(context);
                      },
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
}

/// Custom painter for the outer dashed circular border
class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashWidth = 5.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final adjustedSweep = (2 * math.pi) / dashCount;
    final dashFraction = dashWidth / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * adjustedSweep;
      final sweepAngle = adjustedSweep * dashFraction;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) =>
      oldDelegate.color != color;
}
