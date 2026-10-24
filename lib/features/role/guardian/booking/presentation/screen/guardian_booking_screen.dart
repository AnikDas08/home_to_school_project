import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/guardian_booking_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/guardian_booking_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianBookingScreen extends StatelessWidget {
  final bool isTab;

  const GuardianBookingScreen({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuardianBookingController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: !isTab,
        leading: isTab
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  size: 28,
                  color: Color(0xFF0F172A),
                ),
                onPressed: () => Get.back(),
              ),
        centerTitle: true,
        title: const CommonText(
          text: 'My Bookings',
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

      /// Body with Segmented Control & Bookings List
      body: GetBuilder<GuardianBookingController>(
        builder: (_) {
          return Column(
            children: [
              10.height,

              /// Segmented Filter Tabs: Upcoming (6), History (4), Cancelled (3)
              _buildSegmentedTabs(controller),

              8.height,

              /// Tab Content
              Expanded(
                child: _buildTabContent(controller),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.bookRide),
        backgroundColor: const Color(0xFF1B2B68),
        elevation: 3,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const CommonText(
          text: 'Add Booking',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Segmented Control with capsule background
  Widget _buildSegmentedTabs(GuardianBookingController controller) {
    final tabs = [
      'Upcoming (${controller.upcomingBookings.length})',
      'History (${controller.historyBookings.length})',
      'Cancelled (${controller.cancelledBookings.length})',
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = controller.selectedTabIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectTab(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 9.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: Color(0x0E000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: CommonText(
                  text: tabs[index],
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF0F172A)
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Tab Content Switcher
  Widget _buildTabContent(GuardianBookingController controller) {
    switch (controller.selectedTabIndex) {
      case 0:
        return _buildUpcomingTab(controller);
      case 1:
        return _buildHistoryTab(controller);
      case 2:
        return _buildCancelledTab(controller);
      default:
        return _buildUpcomingTab(controller);
    }
  }

  /// Upcoming Tab with 2 Sections
  Widget _buildUpcomingTab(GuardianBookingController controller) {
    final active = controller.activeTrips;
    final scheduled = controller.scheduledCommutes;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. Section Header: Active Trip Right Now
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 14.h, bottom: 8.h),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                8.width,
                CommonText(
                  text: 'ACTIVE TRIP RIGHT NOW (${active.length})',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                ),
              ],
            ),
          ),

          /// Active Trip Cards
          ...active.map(
            (b) => GuardianBookingCard(
              booking: b,
              onTap: () => Get.toNamed(AppRoutes.tripDetails),
              onTrack: () => Get.toNamed(AppRoutes.guardianLiveTrack),
            ),
          ),

          14.height,

          /// 2. Section Header: Scheduled Commutes
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 6.h, bottom: 8.h),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 15.sp,
                  color: const Color(0xFF64748B),
                ),
                8.width,
                CommonText(
                  text: 'SCHEDULED COMMUTES (${scheduled.length})',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                ),
              ],
            ),
          ),

          /// Scheduled Commutes Cards
          ...scheduled.map(
            (b) => GuardianBookingCard(
              booking: b,
              onTap: () => Get.toNamed(AppRoutes.tripDetails),
            ),
          ),
        ],
      ),
    );
  }

  /// History Tab (4 Cards)
  Widget _buildHistoryTab(GuardianBookingController controller) {
    final list = controller.historyBookings;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GuardianBookingCard(
          booking: list[index],
          onTap: () => Get.toNamed(AppRoutes.tripDetails),
        );
      },
    );
  }

  /// Cancelled Tab (3 Cards)
  Widget _buildCancelledTab(GuardianBookingController controller) {
    final list = controller.cancelledBookings;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GuardianBookingCard(
          booking: list[index],
          onTap: () => Get.toNamed(AppRoutes.tripDetails),
        );
      },
    );
  }
}
