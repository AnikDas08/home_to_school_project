import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/component/text_field/common_text_field.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/helpers/validation.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: AppString.changePassword,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CommonTextField(
                    controller: controller.currentPasswordController,
                    isPassword: true,
                    hintText: AppString.currentPassword,
                    validator: AppValidation.password,
                  ),
                  SizedBox(height: 16.h),
                  CommonTextField(
                    controller: controller.newPasswordController,
                    isPassword: true,
                    hintText: AppString.newPassword,
                    validator: AppValidation.password,
                  ),
                  SizedBox(height: 16.h),
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    isPassword: true,
                    hintText: AppString.confirmPassword,
                    validator: (val) => AppValidation.confirmPassword(
                      val,
                      controller.newPasswordController,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CommonButton(
                    titleText: AppString.changePassword,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.changePassword();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
