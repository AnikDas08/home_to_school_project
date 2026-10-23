import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_card_container.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookRideServiceTypeCard extends StatelessWidget {
  const BookRideServiceTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookARideController>(
      builder: (controller) {
        final isDriver = controller.serviceType == 'Driver';
        final isGuide = controller.serviceType == 'WalkShare Guide';

        return BookRideCardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 20.sp,
                    color: const Color(0xFF0F172A),
                  ),
                  8.width,
                  const CommonText(
                    text: 'Service type',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ],
              ),

              14.height,

              Row(
                children: [
                  /// Driver Option
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setServiceType('Driver'),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: isDriver
                              ? const Color(0xFFF8FAFC)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isDriver
                                ? const Color(0xFF1B2B68)
                                : const Color(0xFFE2E8F0),
                            width: isDriver ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car_rounded,
                              size: 18.sp,
                              color: const Color(0xFF1B2B68),
                            ),
                            8.width,
                            const CommonText(
                              text: 'Driver',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  12.width,

                  /// WalkShare Guide Option
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          controller.setServiceType('WalkShare Guide'),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: isGuide
                              ? const Color(0xFFF8FAFC)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isGuide
                                ? const Color(0xFF1B2B68)
                                : const Color(0xFFE2E8F0),
                            width: isGuide ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              size: 18.sp,
                              color: const Color(0xFF64748B),
                            ),
                            8.width,
                            const CommonText(
                              text: 'WalkShare Guide',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
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
