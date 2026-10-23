import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ProfileMenuRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? badgeText;
  final VoidCallback? onTap;
  final bool showDivider;

  const ProfileMenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.badgeText,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          splashColor: const Color(0xFFF8FAFC),
          highlightColor: const Color(0xFFF1F5F9),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            child: Row(
              children: [
                /// Left Icon Box
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 19.sp,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),

                14.width,

                /// Title Text
                Expanded(
                  child: CommonText(
                    text: title,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                    textAlign: TextAlign.start
                  ),
                ),

                /// Optional Pill Badge (e.g. "3" for My Children)
                if (badgeText != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      badgeText!,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        height: 1.1,
                      ),
                    ),
                  ),
                  6.width,
                ],

                /// Chevron Right Arrow
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        ),

        /// Hairline Divider
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
