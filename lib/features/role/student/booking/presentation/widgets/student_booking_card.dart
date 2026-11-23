import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/student/booking/presentation/controller/student_bookings_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentBookingCard extends StatelessWidget {
  final StudentBookingItem booking;
  final VoidCallback? onCancel;

  const StudentBookingCard({
    super.key,
    required this.booking,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = booking.status.toLowerCase().contains('completed');
    final bool isCancelled = booking.status.toLowerCase().contains('cancel');
    final bool isWalkShare = booking.serviceType.toLowerCase().contains('walk');

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.studentRideDetails,
        arguments: {'bookingId': booking.id},
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1. Header Row: Date Badge, Service Type & Fare
            Row(
              children: [
                /// Date capsule
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        booking.month,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E3A8A),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        booking.day,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),

                12.width,

                /// Service info & Trip time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isWalkShare
                                ? Icons.directions_walk_rounded
                                : Icons.directions_car_filled_rounded,
                            size: 15.sp,
                            color: isWalkShare
                                ? const Color(0xFF10B981)
                                : const Color(0xFF1E3A8A),
                          ),
                          4.width,
                          Flexible(
                            child: CommonText(
                              text: booking.serviceType,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (booking.isRoundTrip) ...[
                            6.width,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'Round Trip',
                                style: TextStyle(
                                  fontSize: 9.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      4.height,
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13.sp,
                            color: const Color(0xFF64748B),
                          ),
                          4.width,
                          Text(
                            '${booking.weekday} • ${booking.time}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Price
                Text(
                  booking.fare,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),

            14.height,

            /// 2. Route Display
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 2.w,
                      height: 24.h,
                      color: const Color(0xFFCBD5E1),
                    ),
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEA580C),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: booking.pickupAddress,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F172A),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      16.height,
                      CommonText(
                        text: booking.dropoffAddress,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F172A),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            14.height,
            const Divider(color: Color(0xFFF1F5F9), height: 1),
            10.height,

            /// 3. Footer Row: Provider info & Status/Actions
            Row(
              children: [
                CircleAvatar(
                  radius: 12.r,
                  backgroundColor: const Color(0xFFEFF6FF),
                  child: Icon(
                    isWalkShare
                        ? Icons.directions_walk_rounded
                        : Icons.person_rounded,
                    size: 14.sp,
                    color: const Color(0xFF1B2B68),
                  ),
                ),
                6.width,
                Expanded(
                  child: Text(
                    booking.providerName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFFECFDF5)
                        : (isCancelled
                            ? const Color(0xFFFEF2F2)
                            : const Color(0xFFEFF6FF)),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? const Color(0xFF10B981)
                          : (isCancelled
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF1E3A8A)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

