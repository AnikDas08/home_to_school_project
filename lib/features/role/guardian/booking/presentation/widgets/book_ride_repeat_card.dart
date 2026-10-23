import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_card_container.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookRideRepeatCard extends StatelessWidget {
  const BookRideRepeatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookARideController>(
      builder: (controller) {
        return BookRideCardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row: Repeat Title & Toggle Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sync_rounded,
                        size: 21.sp,
                        color: const Color(0xFF0F172A),
                      ),
                      8.width,
                      const CommonText(
                        text: 'Repeat',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ],
                  ),

                  /// Active Switch (matching Image 2)
                  Transform.scale(
                    scale: 0.82,
                    child: Switch(
                      value: controller.repeatEnabled,
                      onChanged: (val) => controller.setRepeatEnabled(val),
                      activeColor: const Color(0xFF1B2B68),
                      activeTrackColor:
                          const Color(0xFF1B2B68).withOpacity(0.4),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFCBD5E1),
                    ),
                  ),
                ],
              ),

              12.height,

              /// Weekly vs Monthly Option Buttons (Matching Image 1 & 2)
              Row(
                children: [
                  /// Weekly Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setRepeatType('Weekly'),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: controller.repeatType == 'Weekly'
                              ? const Color(0xFFF1F5F9).withOpacity(0.6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: controller.repeatType == 'Weekly'
                                ? const Color(0xFF1B2B68)
                                : const Color(0xFFE2E8F0),
                            width: controller.repeatType == 'Weekly'
                                ? 1.5
                                : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 16.sp,
                              color: const Color(0xFF0F172A),
                            ),
                            8.width,
                            CommonText(
                              text: 'Weekly',
                              fontSize: 13,
                              fontWeight: controller.repeatType == 'Weekly'
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  12.width,

                  /// Monthly Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setRepeatType('Monthly'),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: controller.repeatType == 'Monthly'
                              ? const Color(0xFFEFF6FF).withOpacity(0.5)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: controller.repeatType == 'Monthly'
                                ? const Color(0xFF2563EB)
                                : const Color(0xFFE2E8F0),
                            width: controller.repeatType == 'Monthly'
                                ? 1.5
                                : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              size: 17.sp,
                              color: const Color(0xFF0F172A),
                            ),
                            8.width,
                            CommonText(
                              text: 'Monthly',
                              fontSize: 13,
                              fontWeight: controller.repeatType == 'Monthly'
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// When Repeat is Enabled, show the Day Selector (Mon - Sun pills from Image 2)
              if (controller.repeatEnabled) ...[
                14.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.weekDays.map((day) {
                    final isSelected = controller.selectedDays.contains(day);

                    return GestureDetector(
                      onTap: () => controller.toggleDay(day),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF1B2B68)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1B2B68)
                                : const Color(0xFFE2E8F0),
                            width: 1.0,
                          ),
                        ),
                        child: CommonText(
                          text: day,
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF334155),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              /// End Date Field (if not until cancelled)
              if (!controller.untilCancelled) ...[
                12.height,
                GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: controller.endDate ??
                          DateTime.now().add(const Duration(days: 30)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      controller.setEndDate(date);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: controller.endDate != null
                              ? DateFormat('EEE, MMM d, yyyy')
                                  .format(controller.endDate!)
                              : 'End date',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: controller.endDate == null
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF0F172A),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 19.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              14.height,

              /// Until Cancelled Checkbox
              GestureDetector(
                onTap: () =>
                    controller.setUntilCancelled(!controller.untilCancelled),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: controller.untilCancelled
                            ? const Color(0xFF1B2B68)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: controller.untilCancelled
                              ? const Color(0xFF1B2B68)
                              : const Color(0xFFCBD5E1),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: controller.untilCancelled
                          ? Icon(
                              Icons.check_rounded,
                              size: 14.sp,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    10.width,
                    const CommonText(
                      text: 'Until cancelled',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
