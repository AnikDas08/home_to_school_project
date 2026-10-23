import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/bottom_nav_bar/common_bottom_bar.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ChatListScreen extends StatelessWidget {
  final bool isTab;
  const ChatListScreen({super.key, this.isTab = false});

  final List<Map<String, dynamic>> _conversations = const [
    {
      'id': '1',
      'name': 'Tariq Ahmed2',
      'message':
          'Got both of them buckled in safely! Heading to Greenfield.',
      'time': '07:34 AM',
      'avatarBg': Color(0xFFEFF6FF),
      'avatarColor': Color(0xFF2563EB),
    },
    {
      'id': '2',
      'name': 'Sarah Jenkins1',
      'message': 'Walking group is 2 minutes from Sunshine Pre-school.',
      'time': '08:12 AM',
      'avatarBg': Color(0xFFFEF2F2),
      'avatarColor': Color(0xFFDC2626),
    },
    {
      'id': '3',
      'name': 'Farhana Yasmin1',
      'message': "Happy to cover Emma's Friday return if Tariq is full.",
      'time': 'Yesterday',
      'avatarBg': Color(0xFFFFFBEB),
      'avatarColor': Color(0xFFD97706),
    },
    {
      'id': '4',
      'name': 'Kabir Hossain',
      'message':
          'Confirmed Mon–Wed backup for Arman\'s soccer practice ride.',
      'time': 'Mon',
      'avatarBg': Color(0xFFF0FDF4),
      'avatarColor': Color(0xFF16A34A),
    },
    {
      'id': '5',
      'name': 'Elena Rostova',
      'message': 'West-gate walk group has space for Zara next week.',
      'time': 'Sun',
      'avatarBg': Color(0xFFFAF5FF),
      'avatarColor': Color(0xFF9333EA),
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            if (Navigator.canPop(context)) {
              Get.back();
            } else if (Get.isRegistered<NavController>()) {
              NavController.instance.resetToHome();
            }
          },
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Messages',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
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

      /// List of Conversations
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _conversations.length,
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFF1F5F9),
        ),
        itemBuilder: (context, index) {
          final item = _conversations[index];

          return InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.message,
                parameters: {
                  'chatId': item['id']!,
                  'name': item['name']!,
                  'image': AppImages.profileImage,
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.asset(
                      AppImages.profileImage,
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        radius: 25.r,
                        backgroundColor: item['avatarBg'] as Color,
                        child: Text(
                          item['name']!.toString().substring(0, 1),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: item['avatarColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                  ),

                  14.width,

                  /// Name and Message Snippet
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: item['name']!,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        4.height,
                        CommonText(
                          text: item['message']!,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  10.width,

                  /// Timestamp
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: CommonText(
                      text: item['time']!,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          isTab ? null : const CommonBottomNavBar(currentIndex: 2),
    );
  }
}
