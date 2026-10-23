import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/sign_up_controller.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  @override
  void initState() {
    super.initState();
    SignUpController.instance.startTimer();
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          final phoneText = controller.numberController.text.isNotEmpty
              ? '${controller.countryCode} ${controller.numberController.text}'
              : '+1 (416) 555-0123';

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  50.height,

                  /// Title
                  const CommonText(
                    text: 'Verify Your Number',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                    textAlign: TextAlign.center,
                  ),

                  10.height,

                  /// Subtitle
                  const CommonText(
                    text: 'Enter the 4-digit code sent to',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    textAlign: TextAlign.center,
                  ),

                  6.height,

                  /// Phone Number & Edit button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        text: phoneText,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      8.width,
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const CommonText(
                          text: 'Edit',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                    ],
                  ),

                  32.height,

                  /// 4-Digit Pin Code Fields
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: controller.otpController,
                      length: 4,
                      autoFocus: true,
                      autoDisposeControllers: false,
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xFF0F172A),
                      textStyle: GoogleFonts.roboto(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      enableActiveFill: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(14.r),
                        fieldHeight: 64.h,
                        fieldWidth: 58.w,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: const Color(0xFFF8FAFC),
                        borderWidth: 1.5,
                        selectedColor: const Color(0xFF1E3A8A),
                        activeColor: const Color(0xFF1E3A8A),
                        inactiveColor: const Color(0xFFE2E8F0),
                      ),
                      onChanged: (val) {
                        controller.update();
                      },
                      onCompleted: (pin) {
                        controller.verifyOtp();
                      },
                    ),
                  ),

                  24.height,

                  /// Resend Code Countdown / Button
                  if (controller.time == '00:00')
                    GestureDetector(
                      onTap: () {
                        controller.startTimer();
                        controller.signUpUser();
                      },
                      child: const CommonText(
                        text: 'Resend code',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3A8A),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CommonText(
                          text: 'Resend code in ',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF64748B),
                        ),
                        CommonText(
                          text: controller.time,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ],
                    ),

                  32.height,

                  /// Verify Button
                  CommonButton(
                    titleText: 'Verify',
                    isLoading: controller.isLoadingVerify,
                    onTap: () {
                      controller.verifyOtp();
                    },
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
}
