import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/controller/driver_request_details_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestRidersCard extends StatelessWidget {
  final List<RiderModel> riders;

  const DriverRequestRidersCard({
    super.key,
    required this.riders,
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
                Icons.people_alt_outlined,
                size: 16.sp,
                color: const Color(0xFF64748B),
              ),
              8.width,
              CommonText(
                text: 'STUDENT RIDERS (${riders.length})',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
                textAlign: TextAlign.start,
              ),
            ],
          ),

          12.height,

          /// Riders List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: riders.length,
            separatorBuilder: (_, __) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const Divider(
                color: Color(0xFFF1F5F9),
                height: 1,
                thickness: 1,
              ),
            ),
            itemBuilder: (context, index) {
              final rider = riders[index];
              return Row(
                children: [
                  /// Child Avatar
                  ClipOval(
                    child: Image.network(
                      rider.avatarUrl,
                      width: 40.w,
                      height: 40.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        AppImages.profileImage,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  12.width,

                  /// Child Name & Grade
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: rider.name,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        2.height,
                        CommonText(
                          text: rider.grade,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
