import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/student/booking/presentation/controller/student_bookings_controller.dart';
import 'package:home_to_school/features/role/student/booking/presentation/widgets/student_booking_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentBookingsScreen extends StatelessWidget {
  final bool isTab;

  const StudentBookingsScreen({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentBookingsController());

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
          text: 'My Campus Rides',
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

      /// Body with Segmented Control & List
      body: GetBuilder<StudentBookingsController>(
        builder: (_) {
          return Column(
            children: [
              10.height,

              /// Segmented Filter Tabs: Upcoming (3), History (3), Cancelled (1)
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

      /// Floating Action Button to Book a Ride
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.studentBookRide),
        backgroundColor: const Color(0xFF1B2B68),
        elevation: 3,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const CommonText(
          text: 'Book Campus Ride',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSegmentedTabs(StudentBookingsController controller) {
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
                  fontSize: 12.5,
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

  Widget _buildTabContent(StudentBookingsController controller) {
    List<StudentBookingItem> list;
    if (controller.selectedTabIndex == 0) {
      list = controller.upcomingBookings;
    } else if (controller.selectedTabIndex == 1) {
      list = controller.historyBookings;
    } else {
      list = controller.cancelledBookings;
    }

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 44.sp,
              color: const Color(0xFFCBD5E1),
            ),
            12.height,
            const CommonText(
              text: 'No rides found',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            4.height,
            const CommonText(
              text: 'Your campus commute bookings will appear here.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 4.h, bottom: 80.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final booking = list[index];
        return StudentBookingCard(
          booking: booking,
          onCancel: controller.selectedTabIndex == 0
              ? () => controller.cancelBooking(booking.id)
              : null,
        );
      },
    );
  }
}

