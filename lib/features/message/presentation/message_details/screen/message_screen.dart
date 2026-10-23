import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/message_controller.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      init: MessageController(),
      builder: (controller) {
        final recipientFirstName = controller.name.isNotEmpty
            ? controller.name.split(' ').first
            : 'Tariq';

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
            titleSpacing: 0,
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(19.r),
                  child: Image.asset(
                    AppImages.profileImage,
                    width: 38.w,
                    height: 38.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 19.r,
                      backgroundColor: const Color(0xFFEFF6FF),
                      child: Icon(
                        Icons.person,
                        size: 22.sp,
                        color: const Color(0xFF1B2B68),
                      ),
                    ),
                  ),
                ),
                10.width,
                CommonText(
                  text: controller.name.isNotEmpty
                      ? controller.name
                      : 'Tariq Ahmed',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ],
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

          /// Messages Body
          body: SafeArea(
            child: Column(
              children: [
                /// Messages Scrollable Area
                Expanded(
                  child: ListView.separated(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    itemCount: controller.messages.length,
                    separatorBuilder: (_, __) => 14.height,
                    itemBuilder: (context, index) {
                      final item = controller.messages[index];

                      /// 1. Status Pill Notification (e.g. Children safely boarded...)
                      if (item.isStatus) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 7.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: const Color(0xFFBFDBFE),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 14.sp,
                                  color: const Color(0xFF1E3A8A),
                                ),
                                6.width,
                                Flexible(
                                  child: CommonText(
                                    text: item.text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E3A8A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      /// 2. Outgoing Bubble (Parent / Right Side - Navy)
                      if (item.isMe) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 0.76.sw),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1B2B68),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: item.text,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  textAlign: TextAlign.start,
                                  maxLines: 4,
                                ),
                                6.height,
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CommonText(
                                    text: item.time,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70,
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      /// 3. Incoming Bubble (Driver / Left Side - White with border)
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 0.76.sw),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x04000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: item.text,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF0F172A),
                                textAlign: TextAlign.start,
                                maxLines: 4,
                              ),
                              6.height,
                              Align(
                                alignment: Alignment.bottomRight,
                                child: CommonText(
                                  text: item.time,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF94A3B8),
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// Quick Reply Pills (Horizontal scrollable)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFF1F5F9),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: controller.quickReplies.map((reply) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: GestureDetector(
                            onTap: () => controller.sendQuickReply(reply),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 6.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.0,
                                ),
                              ),
                              child: CommonText(
                                text: reply,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0F172A),
                                maxLines: 4,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                /// Bottom Message Input Bar
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                  child: Row(
                    children: [
                      /// Pill-shaped Input Container
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.0,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TextField(
                            controller: controller.messageController,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF0F172A),
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Type a message to $recipientFirstName...',
                              hintStyle: TextStyle(
                                fontSize: 13.5.sp,
                                color: const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 11.h),
                            ),
                            onSubmitted: (_) => controller.sendMessage(),
                          ),
                        ),
                      ),

                      10.width,

                      /// Send Button (Navy circular)
                      GestureDetector(
                        onTap: controller.sendMessage,
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1B2B68),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -0.4,
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
