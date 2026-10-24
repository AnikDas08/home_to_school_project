import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_header_widget.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_safe_ride_banner.dart';
import 'package:home_to_school/features/role/walkshare/schedule/presentation/widgets/walkshare_trip_card.dart';
import 'package:home_to_school/features/role/walkshare/home/presentation/controller/walkshare_home_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareHomeScreen extends StatelessWidget {
  const WalkshareHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareHomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<WalkshareHomeController>(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. Top Header: Avatar, "Hello, John 👋", Subtitle, Notification
                  GuardianHeaderWidget(
                    userName: controller.userName,
                    subtitle: 'Where would you like to go?',
                    notificationCount: 2,
                  ),

                  18.height,

                  /// 2. Promo Banner: Safe Ride Brighter Future
                  const GuardianSafeRideBanner(),

                  22.height,

                  /// 3. Quick Actions: Requests & Availability
                  _buildQuickActions(controller),

                  22.height,

                  /// 4. Today's Trips section (3 cards matching Image 1)
                  _buildTodaysTrips(controller),

                  24.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// 3. Quick Actions
  Widget _buildQuickActions(WalkshareHomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          text: 'Quick Actions',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
          textAlign: TextAlign.start,
        ),
        14.height,
        Row(
          children: [
            /// 1. Requests Card
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: controller.onRequestsTap,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.inbox_outlined,
                            color: const Color(0xFF2563EB),
                            size: 22.sp,
                          ),
                        ),
                        10.height,
                        const CommonText(
                          text: 'Requests',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            12.width,

            /// 2. Availability Card
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: controller.onAvailabilityTap,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.access_time_rounded,
                            color: const Color(0xFFEA580C),
                            size: 22.sp,
                          ),
                        ),
                        10.height,
                        const CommonText(
                          text: 'Availability',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 4. Today's Trips
  Widget _buildTodaysTrips(WalkshareHomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

        /// Trip Card 1 (07:30 AM One-way)
        WalkshareTripCard(
          month: 'MAY',
          day: '22',
          weekday: 'Wed',
          timeText: '07:30 AM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: WalkBadgeType.oneWay,
          onTap: () => Get.toNamed(AppRoutes.walkshareActiveTrip),
        ),

        12.height,

        /// Trip Card 2 (07:30 AM & 01:00 PM Round Trip)
        WalkshareTripCard(
          month: 'MAY',
          day: '23',
          weekday: 'Wed',
          timeText: '07:30 AM & 01:00 PM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: WalkBadgeType.roundTrip,
          onTap: () => Get.toNamed(AppRoutes.walkshareActiveTrip),
        ),

        12.height,

        /// Trip Card 3 (07:30 AM & 01:00 PM Round Trip)
        WalkshareTripCard(
          month: 'MAY',
          day: '24',
          weekday: 'Wed',
          timeText: '07:30 AM & 01:00 PM',
          pickupAddress: '9 Harbourview Lane',
          destinationAddress: 'Greenfield International',
          badgeType: WalkBadgeType.roundTrip,
          onTap: () => Get.toNamed(AppRoutes.walkshareActiveTrip),
        ),
      ],
    );
  }
}
