import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestRouteCard extends StatelessWidget {
  final String pickupAddress;
  final String pickupLabel;
  final String destinationAddress;
  final String destinationLabel;

  const DriverRequestRouteCard({
    super.key,
    required this.pickupAddress,
    required this.pickupLabel,
    required this.destinationAddress,
    required this.destinationLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Header
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: const Color(0xFF64748B),
              ),
              8.width,
              const CommonText(
                text: 'ROUTE',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                textAlign: TextAlign.start,
              ),
            ],
          ),

          14.height,

          /// Pickup Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Blue Donut Icon
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1B2B68),
                      width: 3.5,
                    ),
                  ),
                ),
              ),

              12.width,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: pickupAddress,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.height,
                    CommonText(
                      text: pickupLabel,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// Vertical Dotted Connector
          Padding(
            padding: EdgeInsets.only(left: 6.w, top: 4.h, bottom: 4.h),
            child: SizedBox(
              height: 20.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: 2.w,
                    height: 3.h,
                    color: const Color(0xFFCBD5E1),
                  ),
                ),
              ),
            ),
          ),

          /// Drop-off Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Orange Pin Icon
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 16.sp,
                  color: const Color(0xFFEA580C),
                ),
              ),

              10.width,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: destinationAddress,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.height,
                    CommonText(
                      text: destinationLabel,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
}
