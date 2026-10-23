import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class SelectChildrenBottomSheet extends StatefulWidget {
  final BookARideController controller;

  const SelectChildrenBottomSheet({
    super.key,
    required this.controller,
  });

  static Future<void> show(BuildContext context, BookARideController controller) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectChildrenBottomSheet(controller: controller),
    );
  }

  @override
  State<SelectChildrenBottomSheet> createState() =>
      _SelectChildrenBottomSheetState();
}

class _SelectChildrenBottomSheetState extends State<SelectChildrenBottomSheet> {
  late Set<String> _tempSelected;

  @override
  void initState() {
    super.initState();
    _tempSelected = Set<String>.from(widget.controller.selectedChildrenIds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Top drag handle
            Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            14.height,

            /// Header Row: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: 'Select Children',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close_rounded,
                      size: 16.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),

            16.height,

            /// Children List
            ...widget.controller.allChildren.map((child) {
              final isChecked = _tempSelected.contains(child.id);

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isChecked) {
                          _tempSelected.remove(child.id);
                        } else {
                          _tempSelected.add(child.id);
                        }
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          /// Checkbox
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? const Color(0xFF1B2B68)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: isChecked
                                    ? const Color(0xFF1B2B68)
                                    : const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: isChecked
                                ? Icon(
                                    Icons.check_rounded,
                                    size: 14.sp,
                                    color: Colors.white,
                                  )
                                : null,
                          ),

                          14.width,

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

                          /// Child Name & Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: child.name,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                                2.height,
                                CommonText(
                                  text: child.school,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF64748B),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 1,
                  ),
                ],
              );
            }).toList(),

            20.height,

            /// Done Button
            GestureDetector(
              onTap: () {
                widget.controller.setChildren(_tempSelected);
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: const CommonText(
                  text: 'Done',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            10.height,
          ],
        ),
      ),
    );
  }
}
