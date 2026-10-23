import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/sign_in_controller.dart';
import '../widgets/country_picker_dialog.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<SignInController>(
          builder: (_) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        80.height,

                        /// Title
                        const CommonText(
                          text: 'Sign in',
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                          textAlign: TextAlign.center,
                        ),

                        8.height,

                        /// Subtitle
                        const CommonText(
                          text: 'Welcome back to Home2School.',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF64748B),
                          textAlign: TextAlign.center,
                        ),

                        32.height,

                        /// Phone Number Input Field
                        Container(
                          height: 52.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              /// Country Picker Trigger
                              GestureDetector(
                                onTap: () {
                                  CountryPickerDialog.show(
                                    context,
                                    selectedCode: controller.countryCode,
                                    onCountrySelected: (country) {
                                      controller.setCountry(
                                        country.flag,
                                        '+${country.dialCode}',
                                      );
                                    },
                                  );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.countryFlag,
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      6.width,
                                      CommonText(
                                        text: controller.countryCode,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      4.width,
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.sp,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// Vertical Divider
                              Container(
                                width: 1,
                                height: 26.h,
                                color: const Color(0xFFE2E8F0),
                              ),

                              /// Mobile Number Input
                              Expanded(
                                child: TextField(
                                  controller: controller.phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF0F172A),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter mobile number',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        16.height,

                        /// Continue Button
                        CommonButton(
                          titleText: 'Continue',
                          isLoading: controller.isLoading,
                          onTap: controller.signInUser,
                        ),

                        28.height,

                        /// "or" Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFE2E8F0),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: const CommonText(
                                text: 'or',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFE2E8F0),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        24.height,

                        /// Continue with Apple Button
                        GestureDetector(
                          onTap: controller.signInWithApple,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/apple_icon.svg',
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                10.width,
                                const CommonText(
                                  text: 'Continue with Apple',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F172A),
                                ),
                              ],
                            ),
                          ),
                        ),

                        12.height,

                        /// Continue with Google Button
                        GestureDetector(
                          onTap: controller.signInWithGoogle,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/google_icon.svg',
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                10.width,
                                const CommonText(
                                  text: 'Continue with Google',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F172A),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        /// "Don't have an account? Sign up"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CommonText(
                              text: "Don't have an account? ",
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF475569),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Get.toNamed(AppRoutes.roleSelection),
                              child: const CommonText(
                                text: 'Sign up',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFEA580C),
                              ),
                            ),
                          ],
                        ),

                        20.height,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
