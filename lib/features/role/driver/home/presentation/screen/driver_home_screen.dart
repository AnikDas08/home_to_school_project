import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/features/role/driver/home/presentation/controller/driver_home_controller.dart';
import 'package:home_to_school/features/role/driver/home/presentation/widgets/driver_quick_actions_widget.dart';
import 'package:home_to_school/features/role/driver/home/presentation/widgets/driver_todays_trips_widget.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_header_widget.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_safe_ride_banner.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverHomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<DriverHomeController>(
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
                  const DriverQuickActionsWidget(),

                  22.height,

                  /// 4. Today's Trips section (3 cards)
                  const DriverTodaysTripsWidget(),

                  24.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
