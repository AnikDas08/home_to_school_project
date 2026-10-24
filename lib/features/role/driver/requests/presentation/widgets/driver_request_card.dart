import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/controller/driver_requests_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestCard extends StatelessWidget {
  final DriverRequestItem item;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback? onTap;

  const DriverRequestCard({
    super.key,
    required this.item,
    required this.onAccept,
    required this.onDecline,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Clickable Card Content (Navigates to Details)
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 1. Top Header: Initials Circle, Name & Kids, Price & Chevron
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Initials Avatar (Soft Pink)
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFCE7F3),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: CommonText(
                  text: item.initials,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFBE185D),
                ),
              ),

              12.width,

              /// Parent Name & Children
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: item.parentName,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    3.height,
                    CommonText(
                      text: item.childrenInfo,
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

              8.width,

              /// Price & Chevron
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: item.price,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1B2B68),
                  ),
                  4.width,
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                ],
              ),
            ],
          ),

          14.height,

          /// 2. Route Section (Pickup & Destination)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left Route Dots & Connector Line
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Column(
                  children: [
                    /// Blue Dot (Pickup)
                    Container(
                      width: 9.w,
                      height: 9.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B2B68),
                        shape: BoxShape.circle,
                      ),
                    ),
                    /// Vertical Connector Line
                    Container(
                      width: 1.5.w,
                      height: 18.h,
                      color: const Color(0xFFCBD5E1),
                    ),
                    /// Orange Location Pin Icon (Destination)
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: const Color(0xFFEA580C),
                    ),
                  ],
                ),
              ),

              10.width,

              /// Right Route Address Labels
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: item.pickupAddress,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.height,
                    CommonText(
                      text: item.destinationAddress,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          14.height,

          /// 3. Days & Time Row
          Row(
            children: [
              /// Calendar Icon + Days
              Icon(
                Icons.calendar_today_outlined,
                size: 14.sp,
                color: const Color(0xFF64748B),
              ),
              6.width,
              CommonText(
                text: item.scheduleDays,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),

              const Spacer(),

              /// Clock Icon + Time
              Icon(
                Icons.access_time_rounded,
                size: 15.sp,
                color: const Color(0xFF64748B),
              ),
              6.width,
              CommonText(
                text: item.scheduleTime,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ],
          ),

          12.height,

          /// 4. Badges Row: "Recurring/One-time" and "X seats"
          Row(
            children: [
              /// Trip Type Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.tripType.toLowerCase().contains('rec')
                          ? Icons.sync_rounded
                          : Icons.calendar_today_outlined,
                      size: 13.sp,
                      color: const Color(0xFF2563EB),
                    ),
                    4.width,
                    CommonText(
                      text: item.tripType,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2563EB),
                    ),
                  ],
                ),
              ),

              8.width,

              /// Seats Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      size: 13.sp,
                      color: const Color(0xFF2563EB),
                    ),
                    4.width,
                    CommonText(
                      text: item.seats,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2563EB),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),

    16.height,

          /// 5. Action Buttons: Accept & Decline (or Accepted/Declined status)
          if (item.status == 'pending')
            Row(
              children: [
                /// Accept Button (Dark Blue with Checkmark)
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAccept,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B2B68),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 17.sp,
                              color: Colors.white,
                            ),
                            6.width,
                            const CommonText(
                              text: 'Accept',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                12.width,

                /// Decline Button (Light Peach with Cross)
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onDecline,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1EB),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cancel_rounded,
                              size: 17.sp,
                              color: const Color(0xFFEA580C),
                            ),
                            6.width,
                            const CommonText(
                              text: 'Decline',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFEA580C),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else if (item.status == 'accepted')
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFA7F3D0)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18.sp,
                    color: const Color(0xFF059669),
                  ),
                  8.width,
                  const CommonText(
                    text: 'Accepted',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF059669),
                  ),
                ],
              ),
            )
          else
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel_rounded,
                    size: 18.sp,
                    color: const Color(0xFFDC2626),
                  ),
                  8.width,
                  const CommonText(
                    text: 'Declined',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFDC2626),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
