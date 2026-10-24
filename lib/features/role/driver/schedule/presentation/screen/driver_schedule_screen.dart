import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/driver/schedule/presentation/controller/driver_schedule_controller.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_trip_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverScheduleScreen extends StatelessWidget {
  final bool isTab;

  const DriverScheduleScreen({
    super.key,
    this.isTab = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverScheduleController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: Color(0xFF0F172A),
          ),
          onPressed: () {
            if (isTab) {
              if (Get.isRegistered<NavController>()) {
                Get.find<NavController>().changeIndex(0);
              } else if (Navigator.of(context).canPop()) {
                Get.back();
              }
            } else {
              Get.back();
            }
          },
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Schedule',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body Content: List of Scheduled Trips matching design
      body: SafeArea(
        child: GetBuilder<DriverScheduleController>(
          builder: (_) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: controller.scheduledTrips.length,
              separatorBuilder: (_, __) => 12.height,
              itemBuilder: (context, index) {
                final trip = controller.scheduledTrips[index];
                return GuardianTripCard(
                  month: trip.month,
                  day: trip.day,
                  weekday: trip.weekday,
                  timeText: trip.timeText,
                  pickupAddress: trip.pickupAddress,
                  destinationAddress: trip.destinationAddress,
                  badgeType: trip.badgeType,
                  onTap: () => Get.toNamed(AppRoutes.driverActiveTrip),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
