import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text_field/common_text_field.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import 'package:home_to_school/utils/helpers/validation.dart';
import '../controller/sign_up_controller.dart';

class SignUpAllField extends StatelessWidget {
  const SignUpAllField({super.key, required this.controller});

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Full Name Field
        CommonTextField(
          controller: controller.nameController,
          hintText: 'Full name',
          fillColor: AppColors.white,
          borderColor: AppColors.borderColor,
          borderRadius: 14,
          paddingHorizontal: 16,
          paddingVertical: 14,
          hintTextColor: const Color(0xFF94A3B8),
          prefixIconConstraints: BoxConstraints(
            minWidth: 44.w,
            minHeight: 24.h,
          ),
          prefixIcon: Icon(
            Icons.person_outline_rounded,
            size: 20.sp,
            color: const Color(0xFF94A3B8),
          ),
          validator: AppValidation.required,
        ),

        14.height,

        /// Email Address Field
        CommonTextField(
          controller: controller.emailController,
          hintText: 'Email address',
          keyboardType: TextInputType.emailAddress,
          fillColor: AppColors.white,
          borderColor: AppColors.borderColor,
          borderRadius: 14,
          paddingHorizontal: 16,
          paddingVertical: 14,
          hintTextColor: const Color(0xFF94A3B8),
          prefixIconConstraints: BoxConstraints(
            minWidth: 44.w,
            minHeight: 24.h,
          ),
          prefixIcon: Icon(
            Icons.mail_outline_rounded,
            size: 20.sp,
            color: const Color(0xFF94A3B8),
          ),
          validator: AppValidation.email,
        ),

        14.height,

        /// Phone Number Field
        CommonTextField(
          controller: controller.numberController,
          hintText: 'Phone number',
          keyboardType: TextInputType.phone,
          fillColor: AppColors.white,
          borderColor: AppColors.borderColor,
          borderRadius: 14,
          paddingHorizontal: 16,
          paddingVertical: 14,
          hintTextColor: const Color(0xFF94A3B8),
          prefixIconConstraints: BoxConstraints(
            minWidth: 44.w,
            minHeight: 24.h,
          ),
          prefixIcon: Icon(
            Icons.phone_outlined,
            size: 20.sp,
            color: const Color(0xFF94A3B8),
          ),
          validator: AppValidation.required,
        ),
      ],
    );
  }
}
