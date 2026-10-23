import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianHeaderWidget extends StatelessWidget {
  final String userName;
  final String subtitle;
  final int notificationCount;

  const GuardianHeaderWidget({
    super.key,
    this.userName = 'John',
    this.subtitle = 'Where would you like to go?',
    this.notificationCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Profile Avatar
        ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Image.asset(
            AppImages.profileImage,
            width: 44.w,
            height: 44.w,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => CircleAvatar(
              radius: 22.r,
              backgroundColor: const Color(0xFFEFF6FF),
              child: Icon(
                Icons.person,
                size: 24.sp,
                color: const Color(0xFF1B2B68),
              ),
            ),
          ),
        ),

        12.width,

        /// Greeting & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonText(
                    text: 'Hello, $userName',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  4.width,
                  Text(
                    '👋',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              3.height,
              CommonText(
                text: subtitle,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ],
          ),
        ),

        /// Notification Bell with Badge
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.notifications),
          child: SizedBox(
            width: 42.w,
            height: 42.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 26.sp,
                  color: const Color(0xFF0F172A),
                ),
                if (notificationCount > 0)
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEA580C),
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 15.w,
                        minHeight: 15.w,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
