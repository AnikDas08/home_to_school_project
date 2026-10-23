import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/available_providers_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ProviderListItem extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onRequestBooking;
  final VoidCallback? onTap;

  const ProviderListItem({
    super.key,
    required this.provider,
    required this.onRequestBooking,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Provider Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image.asset(
                  AppImages.profileImage,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => CircleAvatar(
                    radius: 25.r,
                    backgroundColor: const Color(0xFFEFF6FF),
                    child: Icon(
                      Icons.person,
                      size: 26.sp,
                      color: const Color(0xFF1B2B68),
                    ),
                  ),
                ),
              ),

              14.width,

              /// Provider Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name and Verified Badge
                    Row(
                      children: [
                        Flexible(
                          child: CommonText(
                            text: provider.name,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (provider.isVerified) ...[
                          6.width,
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16.sp,
                            color: const Color(0xFF38BDF8),
                          ),
                        ],
                      ],
                    ),

                    3.height,

                    /// Rating & Distance
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 15.sp,
                          color: const Color(0xFFF59E0B),
                        ),
                        3.width,
                        CommonText(
                          text:
                              '${provider.rating} · ${provider.distanceKm} km',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ],
                    ),

                    3.height,

                    /// Vehicle Info
                    CommonText(
                      text: '${provider.vehicle} · ${provider.seats} seats',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),

              10.width,

              /// Request Booking CTA Link
              GestureDetector(
                onTap: onRequestBooking,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const CommonText(
                    text: 'Request Booking',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B2B68),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

        const Divider(
          color: Color(0xFFF1F5F9),
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
