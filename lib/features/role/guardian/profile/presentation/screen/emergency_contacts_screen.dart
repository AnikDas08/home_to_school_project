import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final List<Map<String, dynamic>> _contacts = [
    {
      'name': 'Farhan Khan',
      'isPrimary': true,
      'details': 'Father • +1 (416) 555-0199',
    },
    {
      'name': 'Rehana Begum',
      'isPrimary': false,
      'details': 'Grandmother • +1 (416) 555-0144',
    },
    {
      'name': 'Greenfield School Main Office',
      'isPrimary': false,
      'details': 'School Admin • +1 (416) 555-0800',
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
          text: 'Emergency Contacts',
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Container(
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
                    children: List.generate(_contacts.length, (index) {
                      final contact = _contacts[index];
                      final isLast = index == _contacts.length - 1;

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Avatar
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

                                12.width,

                                /// Contact Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: CommonText(
                                              text: contact['name']!,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (contact['isPrimary'] == true) ...[
                                            6.width,
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 7.w,
                                                vertical: 2.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFEFF6FF),
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFFBFDBFE),
                                                  width: 0.8,
                                                ),
                                              ),
                                              child: const CommonText(
                                                text: 'Primary',
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF2563EB),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      3.height,
                                      CommonText(
                                        text: contact['details']!,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ],
                                  ),
                                ),

                                /// 3 Dots Dropdown Menu
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
                                      AppSnackbar.success(
                                        title: 'Edit',
                                        message:
                                            'Edit ${contact['name']} details',
                                      );
                                    } else if (value == 'delete') {
                                      final name = contact['name'];
                                      setState(() {
                                        _contacts.removeAt(index);
                                      });
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
              ),
            ),

            /// Add Contact Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2B68),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                      8.width,
                      const CommonText(
                        text: 'Add Contact',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
