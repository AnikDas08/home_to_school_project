import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/component/text_field/common_phone_number_text_filed.dart';
import 'package:home_to_school/component/text_field/common_text_field.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import 'package:home_to_school/utils/helpers/validation.dart';

import '../controller/profile_controller.dart';

class EditProfileAllFiled extends StatelessWidget {
  final ProfileController controller;

  const EditProfileAllFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Full name
        const CommonText(text: AppString.fullName, fontWeight: FontWeight.w600),

        12.height,

        CommonTextField(
          controller: controller.nameController,
          validator: AppValidation.required,
          hintText: AppString.fullName,
          borderColor: AppColors.black,
          fillColor: AppColors.transparent,
        ),

        20.height,

        /// Phone number
        const CommonText(text: AppString.contact, fontWeight: .w600),

        12.height,

        CommonPhoneNumberTextFiled(
          controller: controller.numberController,
          countryChange: (Country value) {}, // if supported
        ),
      ],
    );
  }
}
