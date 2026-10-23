import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_card_container.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/select_date_bottom_sheet.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookRideDateTimeCard extends StatelessWidget {
  const BookRideDateTimeCard({super.key});

  Future<void> _pickTime(
    BuildContext context,
    BookARideController controller, {
    required bool isPickup,
  }) async {
    final initial = isPickup
        ? const TimeOfDay(hour: 7, minute: 30)
        : const TimeOfDay(hour: 15, minute: 30);

    final time = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B2B68),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      final formatted = '$hour:$minute $period';

      if (isPickup) {
        controller.setPickupTime(formatted);
      } else {
        controller.setDropOffTime(formatted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookARideController>(
      builder: (controller) {
        return BookRideCardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row: Title and One Way / Round Trip Capsule
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 19.sp,
                        color: const Color(0xFF0F172A),
                      ),
                      8.width,
                      const CommonText(
                        text: 'Date & Time',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ],
                  ),

                  /// Capsule Switcher: One way vs Round trip
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => controller.setRoundTrip(false),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: !controller.isRoundTrip
                                  ? const Color(0xFF1B2B68)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: CommonText(
                              text: 'One way',
                              fontSize: 11.5,
                              fontWeight: !controller.isRoundTrip
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: !controller.isRoundTrip
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.setRoundTrip(true),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: controller.isRoundTrip
                                  ? const Color(0xFF1B2B68)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: CommonText(
                              text: 'Round trip',
                              fontSize: 11.5,
                              fontWeight: controller.isRoundTrip
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: controller.isRoundTrip
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              14.height,

              /// Date Selection Row
              GestureDetector(
                onTap: () => SelectDateBottomSheet.show(context, controller),
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
                        text: controller.formattedSelectedDate,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F172A),
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

              10.height,

              /// Time Selection Row (Pickup & Drop-off times)
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickTime(
                        context,
                        controller,
                        isPickup: true,
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 11.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: controller.pickupTime ??
                                  'Select pickup time',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: controller.pickupTime == null
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF0F172A),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 18.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickTime(
                        context,
                        controller,
                        isPickup: false,
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 11.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: controller.dropOffTime ??
                                  'Select drop off time',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: controller.dropOffTime == null
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF0F172A),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 18.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
