import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/controller/guardian_profile_controller.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import 'package:home_to_school/utils/helpers/other_helper.dart';

class AddNewChildScreen extends StatefulWidget {
  const AddNewChildScreen({super.key});

  @override
  State<AddNewChildScreen> createState() => _AddNewChildScreenState();
}

class _AddNewChildScreenState extends State<AddNewChildScreen> {
  final _nameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _gradeController = TextEditingController();

  String? _image;
  bool _isLoading = false;

  final List<String> _gradeOptions = [
    'Kindergarten',
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
    'Grade 6',
    'Grade 7',
    'Grade 8',
    'Grade 9',
    'Grade 10',
    'Grade 11',
    'Grade 12',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _schoolController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  Future<void> _openGallery() async {
    final picked = await OtherHelper.pickImage();
    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
  }

  void _selectGrade(String grade) {
    setState(() {
      _gradeController.text = grade;
    });
  }

  void _onSaveChild() {
    final name = _nameController.text.trim();
    final school = _schoolController.text.trim();
    final grade = _gradeController.text.trim();

    if (name.isEmpty) {
      AppSnackbar.error(
        title: 'Child Name Required',
        message: "Please enter child's full name",
      );
      return;
    }

    if (Get.isRegistered<GuardianProfileController>()) {
      final profileCtrl = Get.find<GuardianProfileController>();
      profileCtrl.childrenCount += 1;
      profileCtrl.update();
    }

    Get.back(result: {
      'name': name,
      'school':
          '${grade.isNotEmpty ? "$grade • " : ""}${school.isNotEmpty ? school : "Greenfield International School"}',
    });

    AppSnackbar.success(
      title: 'Success',
      message: 'Child added successfully',
    );
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        title: const CommonText(
          text: 'Add Child',
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
      body: GestureDetector(
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
                text: 'Add Child',
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
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  File(_image!),
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
                          onTap: _openGallery,
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
                controller: _nameController,
                hintText: "Child's Full Name",
                prefixIcon: Icons.person_outline_rounded,
              ),

              14.height,

              /// Input 2: School Name
              _buildInputField(
                controller: _schoolController,
                hintText: 'School Name',
                prefixIcon: Icons.menu_book_outlined,
              ),

              14.height,

              /// Input 3: Grade (with dropdown picker)
              GestureDetector(
                onTap: () => _showGradePicker(context),
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
                          text: _gradeController.text.isNotEmpty
                              ? _gradeController.text
                              : 'Grade',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _gradeController.text.isNotEmpty
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

              /// Button: Add Child
              CommonButton(
                titleText: 'Add Child',
                isLoading: _isLoading,
                onTap: _onSaveChild,
              ),

              40.height,
            ],
          ),
        ),
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

  void _showGradePicker(BuildContext context) {
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
                    itemCount: _gradeOptions.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: Color(0xFFF8FAFC)),
                    itemBuilder: (context, index) {
                      final grade = _gradeOptions[index];
                      final isSelected = _gradeController.text == grade;
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
                          _selectGrade(grade);
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
