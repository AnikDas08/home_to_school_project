import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

enum TripBadgeType { oneWay, roundTrip }

class GuardianTripCard extends StatelessWidget {
  final String month;
  final String day;
  final String weekday;
  final String timeText;
  final String pickupAddress;
  final String destinationAddress;
  final TripBadgeType badgeType;
  final VoidCallback? onTap;

  const GuardianTripCard({
    super.key,
    required this.month,
    required this.day,
    required this.weekday,
    required this.timeText,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.badgeType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isOneWay = badgeType == TripBadgeType.oneWay;

    final cardContent = Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Left Date Badge
          Container(
            width: 52.w,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: month,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
                1.height,
                CommonText(
                  text: day,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
                1.height,
                CommonText(
                  text: weekday,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ),

          14.width,

          /// Middle & Right Route Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Time & Trip Badge Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      text: timeText,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),

                    /// Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: isOneWay
                            ? const Color(0xFFFFF7ED)
                            : const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isOneWay
                                ? Icons.arrow_forward_rounded
                                : Icons.sync_alt_rounded,
                            size: 11.sp,
                            color: isOneWay
                                ? const Color(0xFFEA580C)
                                : const Color(0xFF2563EB),
                          ),
                          4.width,
                          CommonText(
                            text: isOneWay ? 'One-way' : 'Round Trip',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isOneWay
                                ? const Color(0xFFEA580C)
                                : const Color(0xFF2563EB),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                10.height,

                /// Route Timeline: Pickup & Dropoff
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Visual connector column
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Column(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF1B2B68),
                            ),
                          ),
                          Container(
                            width: 1.5,
                            height: 14.h,
                            color: const Color(0xFFCBD5E1),
                          ),
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF1B2B68),
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    10.width,

                    /// Addresses
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: pickupAddress,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                          10.height,
                          CommonText(
                            text: destinationAddress,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
