import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/guardian_booking_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianBookingCard extends StatelessWidget {
  final GuardianBookingModel booking;
  final VoidCallback? onTrack;
  final VoidCallback? onRate;
  final VoidCallback? onBookAgain;
  final VoidCallback? onTap;

  const GuardianBookingCard({
    super.key,
    required this.booking,
    this.onTrack,
    this.onRate,
    this.onBookAgain,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x06000000),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1. Top Row: Date, Time & Trip Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    /// Calendar Icon Box
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        size: 18.sp,
                        color: const Color(0xFF1E3A8A),
                      ),
                    ),

                    10.width,

                    /// Date & Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: booking.date,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        2.height,
                        CommonText(
                          text: booking.time,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Badge (Round Trip vs One-way)
                _buildBadge(booking.badgeType),
              ],
            ),

            14.height,

            /// 2. Middle Row: Pickup / Destination & Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Route Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Pickup
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E3A8A),
                              shape: BoxShape.circle,
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: CommonText(
                              text: booking.pickup,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E293B),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),

                      /// Connector line
                      Container(
                        width: 1.5.w,
                        height: 14.h,
                        margin: EdgeInsets.only(left: 3.25.w),
                        color: const Color(0xFFCBD5E1),
                      ),

                      /// Destination
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF1E3A8A),
                                width: 2.w,
                              ),
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: CommonText(
                              text: booking.destination,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E293B),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                12.width,

                /// Price
                CommonText(
                  text: '\$${booking.price}',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ],
            ),

            12.height,
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFF1F5F9),
            ),
            12.height,

            /// 3. Bottom Row: Driver Profile & Action Button(s)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Driver Avatar & Details
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(17.r),
                      child: Image.asset(
                        AppImages.profileImage,
                        width: 34.w,
                        height: 34.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => CircleAvatar(
                          radius: 17.r,
                          backgroundColor: const Color(0xFFEFF6FF),
                          child: Icon(
                            Icons.person,
                            size: 18.sp,
                            color: const Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                    ),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: booking.driverName,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        2.height,
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 14.sp,
                              color: const Color(0xFFF59E0B),
                            ),
                            3.width,
                            CommonText(
                              text: booking.driverRating,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Action Buttons
                _buildActionButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Badge Widget
  Widget _buildBadge(BookingBadgeType type) {
    if (type == BookingBadgeType.roundTrip) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sync_rounded,
              size: 14.sp,
              color: const Color(0xFF2563EB),
            ),
            4.width,
            const CommonText(
              text: 'Round Trip',
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_forward_rounded,
            size: 13.sp,
            color: const Color(0xFFEA580C),
          ),
          4.width,
          const CommonText(
            text: 'One-way',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFFEA580C),
          ),
        ],
      ),
    );
  }

  /// Action Buttons (Track, Chevron, Rate + Book again, or Book again only)
  Widget _buildActionButton(BuildContext context) {
    switch (booking.actionType) {
      case BookingActionType.track:
        return GestureDetector(
          onTap: onTrack,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.5.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.navigation_rounded,
                  size: 13.sp,
                  color: Colors.white,
                ),
                5.width,
                const CommonText(
                  text: 'Track',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );

      case BookingActionType.details:
        return Container(
          width: 32.w,
          height: 32.w,
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.chevron_right_rounded,
            size: 20.sp,
            color: const Color(0xFF94A3B8),
          ),
        );

      case BookingActionType.rateAndRebook:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Rate Button
            GestureDetector(
              onTap: onRate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFFDE68A),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 13.sp,
                      color: const Color(0xFFD97706),
                    ),
                    3.width,
                    const CommonText(
                      text: 'Rate',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD97706),
                    ),
                  ],
                ),
              ),
            ),

            8.width,

            /// Book Again Button
            GestureDetector(
              onTap: onBookAgain,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sync_rounded,
                      size: 13.sp,
                      color: Colors.white,
                    ),
                    4.width,
                    const CommonText(
                      text: 'Book again',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

      case BookingActionType.rebookOnly:
        return GestureDetector(
          onTap: onBookAgain,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.5.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sync_rounded,
                  size: 13.sp,
                  color: Colors.white,
                ),
                4.width,
                const CommonText(
                  text: 'Book again',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
    }
  }
}
