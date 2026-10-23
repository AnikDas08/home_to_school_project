import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/notifications/presentation/controller/notifications_controller.dart';
import 'package:home_to_school/features/notifications/presentation/widgets/notification_item.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
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
        centerTitle: true,
        title: const CommonText(
          text: 'Notifications',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        actions: [
          GetBuilder<NotificationsController>(
            builder: (_) => TextButton(
              onPressed: controller.markAllAsRead,
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              child: const CommonText(
                text: 'Mark Read',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2B68),
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body with Tabs and List
      body: GetBuilder<NotificationsController>(
        builder: (_) {
          final items = controller.filteredNotifications;

          return Column(
            children: [
              /// Tabs (All / Unread)
              _buildTabs(controller),

              /// Notifications List
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 48.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                            12.height,
                            const CommonText(
                              text: 'No notifications',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return NotificationItem(
                            item: item,
                            onTap: () => controller.toggleRead(item.id),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Build All and Unread filter tabs
  Widget _buildTabs(NotificationsController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              /// All Tab
              _buildTabItem(
                title: 'All',
                count: controller.allCount,
                isSelected: controller.selectedTabIndex == 0,
                isUnreadBadge: false,
                onTap: () => controller.selectTab(0),
              ),

              24.width,

              /// Unread Tab
              _buildTabItem(
                title: 'Unread',
                count: controller.unreadCount,
                isSelected: controller.selectedTabIndex == 1,
                isUnreadBadge: true,
                onTap: () => controller.selectTab(1),
              ),
            ],
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ],
      ),
    );
  }

  /// Individual tab item with pill badge and bottom underline
  Widget _buildTabItem({
    required String title,
    required int count,
    required bool isSelected,
    required bool isUnreadBadge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 10.h),
            child: Row(
              children: [
                CommonText(
                  text: title,
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF0F172A)
                      : const Color(0xFF64748B),
                ),
                6.width,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isUnreadBadge
                        ? const Color(0xFFFEE2E2)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: isUnreadBadge
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF334155),
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2.5.h,
            width: title == 'All' ? 52.w : 76.w,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0F172A) : Colors.transparent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }
}
