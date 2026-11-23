import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentTodaysTripsWidget extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const StudentTodaysTripsWidget({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonText(
              text: "Today's Campus Rides",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            GestureDetector(
              onTap: onSeeAll ?? () => Get.toNamed(AppRoutes.studentBookings),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  const CommonText(
                    text: 'View all',
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

        /// Trip Card 1: Morning to Campus
        _buildTripCard(
          context: context,
          tag: 'CAMPUS ARRIVAL',
          tagColor: const Color(0xFF10B981),
          tagBg: const Color(0xFFECFDF5),
          time: '08:15 AM',
          status: 'Confirmed',
          pickupTitle: 'Pickup (Home)',
          pickupAddress: '18 Maple Avenue, Toronto',
          dropoffTitle: 'Drop-off (Campus)',
          dropoffAddress: 'Seneca College - Newnham Gate 3',
          driverName: 'David Miller',
          driverRating: '4.95',
          vehicleInfo: 'Toyota Sienna • SCH-4091',
          serviceType: 'Carpool Ride',
          onTap: () => Get.toNamed(AppRoutes.studentRideDetails),
        ),

        14.height,

        /// Trip Card 2: Afternoon Campus Return
        _buildTripCard(
          context: context,
          tag: 'CAMPUS RETURN',
          tagColor: const Color(0xFF1E3A8A),
          tagBg: const Color(0xFFEFF6FF),
          time: '04:30 PM',
          status: 'Scheduled',
          pickupTitle: 'Pickup (Campus)',
          pickupAddress: 'Seneca College - Student Union',
          dropoffTitle: 'Drop-off (Home)',
          dropoffAddress: '18 Maple Avenue, Toronto',
          driverName: 'Sarah Jenkins',
          driverRating: '4.88',
          vehicleInfo: 'WalkShare Group • 4 Students',
          serviceType: 'WalkShare Commute',
          onTap: () => Get.toNamed(AppRoutes.studentRideDetails),
        ),
      ],
    );
  }

  Widget _buildTripCard({
    required BuildContext context,
    required String tag,
    required Color tagColor,
    required Color tagBg,
    required String time,
    required String status,
    required String pickupTitle,
    required String pickupAddress,
    required String dropoffTitle,
    required String dropoffAddress,
    required String driverName,
    required String driverRating,
    required String vehicleInfo,
    required String serviceType,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
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
            /// Top Row: Tag, Time & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: tagBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w700,
                      color: tagColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                    4.width,
                    CommonText(
                      text: time,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    8.width,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            14.height,

            /// Pickup & Drop-off route
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Color(0x3310B981), blurRadius: 4),
                        ],
                      ),
                    ),
                    Container(
                      width: 2.w,
                      height: 28.h,
                      color: const Color(0xFFCBD5E1),
                    ),
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEA580C),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Color(0x33EA580C), blurRadius: 4),
                        ],
                      ),
                    ),
                  ],
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: pickupAddress,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      20.height,
                      CommonText(
                        text: dropoffAddress,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
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
            12.height,

            /// Driver / Provider Footer
            Row(
              children: [
                CircleAvatar(
                  radius: 14.r,
                  backgroundColor: const Color(0xFFEFF6FF),
                  child: Icon(
                    Icons.person_rounded,
                    size: 16.sp,
                    color: const Color(0xFF1B2B68),
                  ),
                ),
                8.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CommonText(
                              text: driverName,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          4.width,
                          Icon(Icons.star_rounded, size: 13.sp, color: const Color(0xFFF59E0B)),
                          Text(
                            driverRating,
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        vehicleInfo,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

