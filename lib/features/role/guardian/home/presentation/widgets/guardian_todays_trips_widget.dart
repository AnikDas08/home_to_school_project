import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import 'guardian_trip_card.dart';

class GuardianTodaysTripsWidget extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const GuardianTodaysTripsWidget({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header
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
              onTap: onSeeAll ?? () => Get.toNamed(AppRoutes.allTrips),
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

        /// Trip Card 1 (One-way)
        const GuardianTripCard(
          month: 'MAY',
          day: '22',
          weekday: 'Wed',
          timeText: '07:30 AM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: TripBadgeType.oneWay,
        ),

        12.height,

        /// Trip Card 2 (Round Trip)
        const GuardianTripCard(
          month: 'MAY',
          day: '22',
          weekday: 'Wed',
          timeText: '07:30 AM & 01:00 PM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: TripBadgeType.roundTrip,
        ),

        12.height,

        /// Trip Card 3 (Round Trip)
        const GuardianTripCard(
          month: 'MAY',
          day: '24',
          weekday: 'Wed',
          timeText: '07:30 AM & 01:00 PM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: TripBadgeType.roundTrip,
        ),
      ],
    );
  }
}
