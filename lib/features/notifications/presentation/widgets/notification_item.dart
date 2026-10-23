import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/notifications/presentation/controller/notifications_controller.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class NotificationItem extends StatelessWidget {
  final AppNotificationItem item;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: const Color(0xFFF8FAFC),
      highlightColor: const Color(0xFFF1F5F9),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Unread Indicator (concentric circle dot) or alignment spacer
                SizedBox(
                  width: 18.w,
                  child: !item.isRead
                      ? Container(
                          margin: EdgeInsets.only(top: 5.h),
                          width: 9.w,
                          height: 9.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFBFDBFE),
                              width: 2.w,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                /// Notification Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonText(
                              text: item.title,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                              color: AppColors.titleColor,
                            ),
                          ),
                          8.width,
                          CommonText(
                            text: item.time,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subtitleColor,
                          ),
                        ],
                      ),
                      5.height,
                      Text(
                        item.message,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Divider between items
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFF1F5F9),
            indent: 20.w,
            endIndent: 20.w,
          ),
        ],
      ),
    );
  }
}
