import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_card_container.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookRidePickupDropoffCard extends StatelessWidget {
  const BookRidePickupDropoffCard({super.key});

  void _showLocationPicker(
    BuildContext context,
    BookARideController controller, {
    required bool isPickup,
  }) {
    final title =
        isPickup ? 'Select Pickup Location' : 'Select Drop-off Location';
    final options = [
      '124 Oxford Street, London (Home)',
      'Greenfield International School, Gate 2',
      'Sunshine Pre-school, Main Entrance',
      'Central Library, St. Peter Square',
      'Grand Park Recreation Center',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                16.height,
                CommonText(
                  text: title,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                12.height,
                ...options.map((opt) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF1B2B68),
                    ),
                    title: CommonText(
                      text: opt,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0F172A),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () {
                      if (isPickup) {
                        controller.setPickupLocation(opt);
                      } else {
                        controller.setDropOffLocation(opt);
                      }
                      Navigator.pop(ctx);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookARideController>(
      builder: (controller) {
        return BookRideCardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row with Title and "On-Demand" Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20.sp,
                        color: const Color(0xFF0F172A),
                      ),
                      8.width,
                      const CommonText(
                        text: 'Pickup & Drop-off',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: controller.toggleOnDemand,
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: controller.isOnDemand
                            ? const Color(0xFF1B2B68)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: controller.isOnDemand
                              ? const Color(0xFF1B2B68)
                              : const Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.isOnDemand) ...[
                            Icon(
                              Icons.check_rounded,
                              size: 13.sp,
                              color: Colors.white,
                            ),
                            4.width,
                          ],
                          CommonText(
                            text: 'On-Demand',
                            fontSize: 11,
                            fontWeight: controller.isOnDemand
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: controller.isOnDemand
                                ? Colors.white
                                : const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              14.height,

              /// Pickup Location Row
              GestureDetector(
                onTap: () => _showLocationPicker(
                  context,
                  controller,
                  isPickup: true,
                ),
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
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 19.sp,
                        color: const Color(0xFF64748B),
                      ),
                      10.width,
                      Expanded(
                        child: CommonText(
                          text: controller.pickupLocation ?? 'Pickup location',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: controller.pickupLocation == null
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF0F172A),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
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

              /// Drop-off Location Row
              GestureDetector(
                onTap: () => _showLocationPicker(
                  context,
                  controller,
                  isPickup: false,
                ),
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
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 19.sp,
                        color: const Color(0xFF64748B),
                      ),
                      10.width,
                      Expanded(
                        child: CommonText(
                          text: controller.dropOffLocation ?? 'Drop-off location',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: controller.dropOffLocation == null
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF0F172A),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
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
          ),
        );
      },
    );
  }
}
