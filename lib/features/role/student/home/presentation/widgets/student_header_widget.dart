import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentHeaderWidget extends StatelessWidget {
  final String userName;
  final String subtitle;
  final int notificationCount;

  const StudentHeaderWidget({
    super.key,
    this.userName = 'Alex',
    this.subtitle = 'Campus Commute • Seneca College',
    this.notificationCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Student Profile Avatar with verified green check badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: LocalStorage.myImage.isNotEmpty
                  ? Image.file(
                      File(LocalStorage.myImage),
                      width: 46.w,
                      height: 46.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildAvatarFallback(),
                    )
                  : Image.asset(
                      AppImages.profileImage,
                      width: 46.w,
                      height: 46.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildAvatarFallback(),
                    ),
            ),
            Positioned(
              bottom: -2.h,
              right: -2.w,
              child: Image.asset(
                AppImages.greenCheck,
                width: 16.sp,
                height: 16.sp,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.check_circle_rounded,
                  size: 16.sp,
                  color: const Color(0xFF22C55E),
                ),
              ),
            ),
          ],
        ),

        12.width,

        /// Greeting & Student Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CommonText(
                      text: 'Hello, $userName',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  4.width,
                  Text(
                    '🎓',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
              3.height,
              CommonText(
                text: subtitle,
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        /// Notification Bell with Badge
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.notifications),
          behavior: HitTestBehavior.opaque,
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
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.w,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        notificationCount > 9 ? '9+' : '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
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

  Widget _buildAvatarFallback() {
    return CircleAvatar(
      radius: 23.r,
      backgroundColor: const Color(0xFFEFF6FF),
      child: Icon(
        Icons.school_rounded,
        size: 24.sp,
        color: const Color(0xFF1B2B68),
      ),
    );
  }
}

