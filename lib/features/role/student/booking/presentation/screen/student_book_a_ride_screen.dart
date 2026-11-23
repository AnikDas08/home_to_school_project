import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/student/booking/presentation/controller/student_book_ride_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentBookARideScreen extends StatelessWidget {
  const StudentBookARideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentBookRideController());

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
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Book Campus Ride',
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

      /// Body Content
      body: SafeArea(
        child: GetBuilder<StudentBookRideController>(
          builder: (ctrl) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 1. Pickup & Drop-off Route Card
                        _buildRouteCard(context, ctrl),

                        16.height,

                        /// 2. Service Type Card: Carpool vs WalkShare
                        _buildServiceTypeCard(ctrl),

                        16.height,

                        /// 3. Date & Schedule Card
                        _buildScheduleCard(context, ctrl),

                        16.height,

                        /// 4. Rider Information (Self Student)
                        _buildRiderCard(ctrl),

                        16.height,

                        /// 5. Notes Card
                        _buildNotesCard(ctrl),

                        20.height,
                      ],
                    ),
                  ),
                ),

                /// Bottom Price & Action Bar
                _buildBottomBar(ctrl),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 1. Route Card with Swap button
  Widget _buildRouteCard(BuildContext context, StudentBookRideController ctrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: 'Commute Route',
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
              GestureDetector(
                onTap: ctrl.swapLocations,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.swap_vert_rounded, size: 15.sp, color: const Color(0xFF1E3A8A)),
                      4.width,
                      Text(
                        'Swap',
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          14.height,

          /// Pickup input
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF5),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.my_location_rounded, size: 14.sp, color: const Color(0xFF10B981)),
              ),
              10.width,
              Expanded(
                child: TextField(
                  controller: ctrl.pickupController,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Pickup Location',
                    labelStyle: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Container(
              width: 1.5,
              height: 20.h,
              color: const Color(0xFFE2E8F0),
            ),
          ),

          /// Dropoff input
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.school_rounded, size: 14.sp, color: const Color(0xFF1E3A8A)),
              ),
              10.width,
              Expanded(
                child: TextField(
                  controller: ctrl.dropoffController,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Campus Drop-off Address',
                    labelStyle: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 2. Service Type Card: Carpool Ride vs WalkShare Commute
  Widget _buildServiceTypeCard(StudentBookRideController ctrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: 'Service Type',
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          12.height,
          Row(
            children: [
              Expanded(
                child: _buildServiceOption(
                  icon: Icons.directions_car_filled_rounded,
                  title: 'Carpool Ride',
                  subtitle: 'Fast vehicular ride',
                  isSelected: ctrl.selectedService == 'Carpool Ride',
                  onTap: () => ctrl.setService('Carpool Ride'),
                ),
              ),
              12.width,
              Expanded(
                child: _buildServiceOption(
                  icon: Icons.directions_walk_rounded,
                  title: 'WalkShare',
                  subtitle: 'Guided student walk',
                  isSelected: ctrl.selectedService == 'WalkShare Commute',
                  onTap: () => ctrl.setService('WalkShare Commute'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F5F9) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1B2B68) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isSelected ? const Color(0xFF1B2B68) : const Color(0xFF64748B),
            ),
            8.height,
            CommonText(
              text: title,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
            2.height,
            CommonText(
              text: subtitle,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }

  /// 3. Schedule Card
  Widget _buildScheduleCard(BuildContext context, StudentBookRideController ctrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: 'Schedule & Timing',
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
              Row(
                children: [
                  Text(
                    'Round Trip',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  6.width,
                  Switch.adaptive(
                    value: ctrl.isRoundTrip,
                    onChanged: ctrl.toggleRoundTrip,
                    activeTrackColor: const Color(0xFF1B2B68),
                  ),
                ],
              ),
            ],
          ),
          10.height,

          /// Date Picker Row
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: ctrl.selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 60)),
              );
              if (picked != null) {
                ctrl.setDate(picked);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_outlined, size: 18.sp, color: const Color(0xFF1B2B68)),
                  10.width,
                  Expanded(
                    child: Text(
                      ctrl.formattedDate,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp, color: const Color(0xFF64748B)),
                ],
              ),
            ),
          ),

          12.height,

          /// Time Picker Rows
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: ctrl.pickupTime,
                    );
                    if (picked != null) {
                      ctrl.setPickupTime(picked);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup Time',
                          style: TextStyle(fontSize: 11.sp, color: const Color(0xFF64748B)),
                        ),
                        4.height,
                        Text(
                          ctrl.formatTimeOfDay(ctrl.pickupTime),
                          style: TextStyle(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (ctrl.isRoundTrip) ...[
                10.width,
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: ctrl.returnTime,
                      );
                      if (picked != null) {
                        ctrl.setReturnTime(picked);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Return Time',
                            style: TextStyle(fontSize: 11.sp, color: const Color(0xFF64748B)),
                          ),
                          4.height,
                          Text(
                            ctrl.formatTimeOfDay(ctrl.returnTime),
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// 4. Rider Info Card (The Student Themselves)
  Widget _buildRiderCard(StudentBookRideController ctrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CommonText(
                text: 'Passenger / Rider',
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
              8.width,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Self (18+)',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ),
            ],
          ),
          12.height,
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: const Color(0xFFEFF6FF),
                child: Icon(Icons.school_rounded, size: 20.sp, color: const Color(0xFF1B2B68)),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CommonText(
                            text: ctrl.studentName,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        6.width,
                        Image.asset(
                          AppImages.greenCheck,
                          width: 14.sp,
                          height: 14.sp,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.check_circle_rounded,
                            size: 14.sp,
                            color: const Color(0xFF22C55E),
                          ),
                        ),
                      ],
                    ),
                    3.height,
                    Text(
                      '${ctrl.institution} • ID: ${ctrl.studentId}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 5. Notes Card
  Widget _buildNotesCard(StudentBookRideController ctrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: 'Pickup Instructions / Notes (Optional)',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          10.height,
          TextField(
            controller: ctrl.notesController,
            maxLines: 2,
            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: 'e.g. Meet by residence lobby or specific gate',
              hintStyle: TextStyle(fontSize: 12.5.sp, color: const Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: EdgeInsets.all(12.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Price & Action Bar
  Widget _buildBottomBar(StudentBookRideController ctrl) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Estimated Fare',
                style: TextStyle(fontSize: 11.5.sp, color: const Color(0xFF64748B)),
              ),
              2.height,
              Text(
                '\$${ctrl.estimatedFare.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          20.width,
          Expanded(
            child: GestureDetector(
              onTap: ctrl.confirmBooking,
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1B2B68).withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const CommonText(
                  text: 'Find Providers',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
