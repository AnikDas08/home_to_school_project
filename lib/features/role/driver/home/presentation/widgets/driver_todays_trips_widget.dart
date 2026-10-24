import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/driver/home/presentation/controller/driver_home_controller.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_trip_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverTodaysTripsWidget extends StatelessWidget {
  const DriverTodaysTripsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverHomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header with "Today's trips" and "See all >"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonText(
              text: "Today's trips",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            GestureDetector(
              onTap: controller.onSeeAllTrips,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  const CommonText(
                    text: 'See all',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B2B68),
                  ),
                  4.width,
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16.sp,
                    color: const Color(0xFF1B2B68),
                  ),
                ],
              ),
            ),
          ],
        ),

        14.height,

        /// Trip Card 1 (07:30 AM One-way) - Navigates to Active Trip
        GuardianTripCard(
          month: 'MAY',
          day: '22',
          weekday: 'Wed',
          timeText: '07:30 AM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: TripBadgeType.oneWay,
          onTap: () => Get.toNamed(AppRoutes.driverActiveTrip),
        ),

        12.height,

        /// Trip Card 2 (07:30 AM & 01:00 PM Round Trip) - Navigates to Active Trip
        GuardianTripCard(
          month: 'MAY',
          day: '22',
          weekday: 'Wed',
          timeText: '07:30 AM & 01:00 PM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: TripBadgeType.roundTrip,
          onTap: () => Get.toNamed(AppRoutes.driverActiveTrip),
        ),

        12.height,

        /// Trip Card 3 (07:30 AM & 01:00 PM Round Trip) - Navigates to Active Trip
        GuardianTripCard(
          month: 'MAY',
          day: '24',
          weekday: 'Wed',
          timeText: '07:30 AM & 01:00 PM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: TripBadgeType.roundTrip,
          onTap: () => Get.toNamed(AppRoutes.driverActiveTrip),
        ),
      ],
    );
  }
}
