import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class SelectDateBottomSheet extends StatefulWidget {
  final BookARideController controller;

  const SelectDateBottomSheet({
    super.key,
    required this.controller,
  });

  static Future<void> show(BuildContext context, BookARideController controller) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectDateBottomSheet(controller: controller),
    );
  }

  @override
  State<SelectDateBottomSheet> createState() => _SelectDateBottomSheetState();
}

class _SelectDateBottomSheetState extends State<SelectDateBottomSheet> {
  late DateTime _displayedMonth;
  late DateTime _tempSelectedDate;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.controller.selectedDate.year,
      widget.controller.selectedDate.month,
      1,
    );
    _tempSelectedDate = widget.controller.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    // Days in current displayed month
    final daysInMonth = DateUtils.getDaysInMonth(
      _displayedMonth.year,
      _displayedMonth.month,
    );
    final firstDayWeekday = _displayedMonth.weekday % 7; // Sunday is 0

    // Previous month overflow days
    final prevMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1, 1);
    final prevMonthTotalDays = DateUtils.getDaysInMonth(
      prevMonth.year,
      prevMonth.month,
    );

    final totalSlots = (firstDayWeekday + daysInMonth > 35) ? 42 : 35;

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

            /// Header: "Select Date" & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: 'Select Date',
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

            /// Month & Year Navigation Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _displayedMonth = DateTime(
                        _displayedMonth.year,
                        _displayedMonth.month - 1,
                        1,
                      );
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 20.sp,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                CommonText(
                  text: DateFormat('MMMM yyyy').format(_displayedMonth),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _displayedMonth = DateTime(
                        _displayedMonth.year,
                        _displayedMonth.month + 1,
                        1,
                      );
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 20.sp,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),

            16.height,

            /// Weekday Labels (Su, Mo, Tu, We, Th, Fr, Sa)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'].map((w) {
                return SizedBox(
                  width: 36.w,
                  child: Center(
                    child: CommonText(
                      text: w,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                );
              }).toList(),
            ),

            10.height,

            /// Days Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalSlots,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                final dayOffset = index - firstDayWeekday;

                if (dayOffset < 0) {
                  // Previous month day
                  final prevDay = prevMonthTotalDays + dayOffset + 1;
                  return Center(
                    child: CommonText(
                      text: '$prevDay',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFCBD5E1),
                    ),
                  );
                } else if (dayOffset >= daysInMonth) {
                  // Next month day
                  final nextDay = dayOffset - daysInMonth + 1;
                  return Center(
                    child: CommonText(
                      text: '$nextDay',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFCBD5E1),
                    ),
                  );
                } else {
                  final currentDayNumber = dayOffset + 1;
                  final dateThisSlot = DateTime(
                    _displayedMonth.year,
                    _displayedMonth.month,
                    currentDayNumber,
                  );

                  final isSelected =
                      _tempSelectedDate.year == dateThisSlot.year &&
                          _tempSelectedDate.month == dateThisSlot.month &&
                          _tempSelectedDate.day == dateThisSlot.day;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _tempSelectedDate = dateThisSlot;
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1B2B68)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: CommonText(
                        text: '$currentDayNumber',
                        fontSize: 13.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                  );
                }
              },
            ),

            20.height,

            /// Done Button
            GestureDetector(
              onTap: () {
                widget.controller.setSelectedDate(_tempSelectedDate);
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
