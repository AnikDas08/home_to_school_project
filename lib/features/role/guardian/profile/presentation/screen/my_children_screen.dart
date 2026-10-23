import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/controller/guardian_profile_controller.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class MyChildrenScreen extends StatefulWidget {
  const MyChildrenScreen({super.key});

  @override
  State<MyChildrenScreen> createState() => _MyChildrenScreenState();
}

class _MyChildrenScreenState extends State<MyChildrenScreen> {
  final List<Map<String, String>> _children = [
    {
      'name': 'Liam Tremblay',
      'school': 'Grade 4 • Greenfield International School',
    },
    {
      'name': 'Emma Tremblay',
      'school': 'Grade 2 • Greenfield International School',
    },
    {
      'name': 'Chloe Tremblay',
      'school': 'Pre-K • Sunshine Pre-school',
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
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'My Children',
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

      /// Body Content
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              /// Children Card List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(_children.length, (index) {
                    final child = _children[index];
                    final isLast = index == _children.length - 1;

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          child: Row(
                            children: [
                              /// Child Avatar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(22.r),
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

                              14.width,

                              /// Name & School Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: child['name']!,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                    3.height,
                                    CommonText(
                                      text: child['school']!,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ],
                                ),
                              ),

                              /// 3 Dots Menu
                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.more_vert_rounded,
                                  color: Color(0xFF94A3B8),
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: const BorderSide(
                                    color: Color(0xFFF1F5F9),
                                    width: 1,
                                  ),
                                ),
                                offset: const Offset(0, 36),
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    Get.toNamed(AppRoutes.addNewChild);
                                  } else if (value == 'delete') {
                                    final name = child['name'];
                                    setState(() {
                                      _children.removeAt(index);
                                    });
                                    if (Get.isRegistered<GuardianProfileController>()) {
                                      final profileCtrl = Get.find<GuardianProfileController>();
                                      if (profileCtrl.childrenCount > 0) {
                                        profileCtrl.childrenCount -= 1;
                                        profileCtrl.update();
                                      }
                                    }
                                    AppSnackbar.success(
                                      title: 'Deleted',
                                      message: '$name removed',
                                    );
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    height: 38.h,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 18.sp,
                                          color: const Color(0xFF0F172A),
                                        ),
                                        10.width,
                                        const CommonText(
                                          text: 'Edit',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuDivider(height: 1),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    height: 38.h,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline_rounded,
                                          size: 18.sp,
                                          color: const Color(0xFFEF4444),
                                        ),
                                        10.width,
                                        const CommonText(
                                          text: 'Delete',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFEF4444),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF1F5F9),
                          ),
                      ],
                    );
                  }),
                ),
              ),

              18.height,

              /// Add Another Child Profile Button
              GestureDetector(
                onTap: () async {
                  final result = await Get.toNamed(AppRoutes.addNewChild);
                  if (result != null && result is Map) {
                    setState(() {
                      _children.add({
                        'name': result['name']?.toString() ?? 'Arman Khan',
                        'school': result['school']?.toString() ??
                            'Grade 3 • Greenfield International School',
                      });
                    });
                  } else if (result == true) {
                    setState(() {
                      _children.add({
                        'name': 'Arman Khan',
                        'school': 'Grade 3 • Greenfield International School',
                      });
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4FD),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: const Color(0xFFD4E0FC),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 20.sp,
                        color: const Color(0xFF1B2B68),
                      ),
                      6.width,
                      const CommonText(
                        text: 'Add Another Child Profile',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B2B68),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
