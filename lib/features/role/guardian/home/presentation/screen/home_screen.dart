import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_header_widget.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_quick_actions_widget.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_safe_ride_banner.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_todays_trips_widget.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = LocalStorage.user?.name.isNotEmpty == true
        ? LocalStorage.user!.name
        : (LocalStorage.myName.isNotEmpty ? LocalStorage.myName : 'John');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _buildHomeTab(userName),
      ),
    );
  }

  Widget _buildHomeTab(String userName) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Section: Avatar, Greeting, Notification
          GuardianHeaderWidget(
            userName: userName,
            subtitle: 'Where would you like to go?',
            notificationCount: 2,
          ),

          18.height,

          /// Promo Banner: Safe Ride Brighter Future
          const GuardianSafeRideBanner(),

          22.height,

          /// Quick Actions: New Booking, My Children, Safety & Help
          const GuardianQuickActionsWidget(),

          22.height,

          /// Today's trips section
          const GuardianTodaysTripsWidget(),

          24.height,
        ],
      ),
    );
  }
}
