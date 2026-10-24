import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestParentCard extends StatelessWidget {
  final String name;
  final String role;
  final bool isVerified;
  final String avatarUrl;
  final VoidCallback onChat;

  const DriverRequestParentCard({
    super.key,
    required this.name,
    required this.role,
    this.isVerified = true,
    required this.avatarUrl,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Parent Avatar
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                AppImages.profileImage,
                width: 48.w,
                height: 48.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          14.width,

          /// Name & Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CommonText(
                        text: name,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerified) ...[
                      6.width,
                      Icon(
                        Icons.verified,
                        size: 16.sp,
                        color: const Color(0xFF2563EB),
                      ),
                    ],
                  ],
                ),
                3.height,
                CommonText(
                  text: role,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          8.width,

          /// Message Button
          GestureDetector(
            onTap: onChat,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18.sp,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
