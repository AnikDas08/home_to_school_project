import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: Image.asset(
                AppImages.onboardingImage,
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            /// Gradient overlay for smooth transition behind text and buttons
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.48, 0.68, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.55),
                      const Color(0xFFC7E1FC).withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),

            /// Foreground Content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    const Spacer(),

                    /// Onboarding Text Graphic
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Image.asset(
                        AppImages.onboardingTextImage,
                        width: 331.w,
                        fit: BoxFit.fill,
                        height: 152.h,
                      ),
                    ),

                    32.height,

                    /// Sign Up Button (Primary Navy)
                    CommonButton(
                      titleText: 'Sign up for free',
                      buttonColor: AppColors.primaryColor,
                      titleColor: AppColors.white,
                      borderColor: AppColors.primaryColor,
                      titleSize: 14,
                      titleWeight: FontWeight.w700,
                      onTap: () => Get.toNamed(AppRoutes.roleSelection),
                    ),

                    10.height,

                    /// Sign In Button (White)
                    CommonButton(
                      titleText: 'Sign In',
                      buttonColor: AppColors.white,
                      titleColor: const Color(0xFF1E2432),
                      borderColor: AppColors.white,
                      buttonHeight: 44.h,
                      buttonRadius: 12.r,
                      titleSize: 14,
                      titleWeight: FontWeight.w700,
                      onTap: () => Get.toNamed(AppRoutes.signIn),
                    ),

                    16.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
