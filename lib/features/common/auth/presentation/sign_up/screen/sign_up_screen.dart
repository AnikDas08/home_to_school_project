import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/sign_up_controller.dart';
import '../widgets/parent_consent_dialog.dart';
import '../widgets/sign_up_all_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.titleColor,
          ),
          onPressed: () => Get.back(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFF1F5F9),
            height: 1,
          ),
        ),
      ),
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  20.height,

                  /// Screen Title
                  const CommonText(
                    text: 'Create your account',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    textAlign: TextAlign.center,
                  ),

                  8.height,

                  /// Screen Subtitle
                  const CommonText(
                    text: 'Enter your details to get started.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtitleColor,
                    textAlign: TextAlign.center,
                  ),

                  28.height,

                  /// Avatar Picker Section with Dashed Outer Ring & Camera Badge
                  Center(
                    child: SizedBox(
                      width: 140.w,
                      height: 140.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          /// Outer Dashed Circle
                          CustomPaint(
                            size: Size(140.w, 140.w),
                            painter: _DashedCirclePainter(
                              color: const Color(0xFFCBD5E1),
                              strokeWidth: 1.5,
                              dashWidth: 5.0,
                              dashSpace: 4.0,
                            ),
                          ),

                          /// Inner Avatar Circle
                          Container(
                            width: 122.w,
                            height: 122.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8EEF5),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: controller.image != null
                                ? ClipOval(
                                    child: Image.file(
                                      File(controller.image!),
                                      width: 122.w,
                                      height: 122.w,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person_rounded,
                                    size: 66.sp,
                                    color: AppColors.primaryColor,
                                  ),
                          ),

                          /// Camera Badge Button
                          Positioned(
                            bottom: 4.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: controller.openGallery,
                              child: Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 18.sp,
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
                    color: AppColors.subtitleColor,
                    textAlign: TextAlign.center,
                  ),

                  28.height,

                  /// Input Form Fields (Full name, Email address, Phone number)
                  SignUpAllField(controller: controller),

                  22.height,

                  /// Continue Button
                  CommonButton(
                    titleText: 'Continue',
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      controller.signUpUser();
                    },
                  ),

                  16.height,

                  /// Terms & Conditions Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: controller.toggleTermsAccepted,
                        child: Container(
                          width: 18.w,
                          height: 18.h,
                          decoration: BoxDecoration(
                            color: controller.isTermsAccepted
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: controller.isTermsAccepted
                                  ? AppColors.primaryColor
                                  : const Color(0xFFCBD5E1),
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: controller.isTermsAccepted
                              ? Icon(
                                  Icons.check,
                                  size: 13.sp,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF475569),
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms & conditions & Privacy Policy',
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.titleColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ParentConsentDialog.show(
                                      context,
                                      onConsent: () {
                                        controller.isTermsAccepted = true;
                                        controller.update();
                                      },
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  24.height,
                ],
              ),
            ),
          );
        },
      ),
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
