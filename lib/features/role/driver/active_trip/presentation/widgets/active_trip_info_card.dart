import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ActiveTripInfoCard extends StatelessWidget {
  final String status;
  final String time;
  final String address;
  final String childrenNames;

  const ActiveTripInfoCard({
    super.key,
    required this.status,
    required this.time,
    required this.address,
    required this.childrenNames,
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
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Status & Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Status Badge: "● On The Way"
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF22C55E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    6.width,
                    CommonText(
                      text: status,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16A34A),
                    ),
                  ],
                ),
              ),

              /// Time
              CommonText(
                text: time,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ],
          ),

          12.height,

          /// Destination / Pickup Address
          CommonText(
            text: address,
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
          ),

          14.height,

          /// Overlapping Child Avatars + Name
          Row(
            children: [
              SizedBox(
                width: 44.w,
                height: 26.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /// Avatar 1 (Left)
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 26.w,
                        height: 26.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: const DecorationImage(
                            image: AssetImage(AppImages.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    /// Avatar 2 (Right, overlapping)
                    Positioned(
                      left: 18.w,
                      child: Container(
                        width: 26.w,
                        height: 26.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: const DecorationImage(
                            image: AssetImage(AppImages.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              10.width,

              /// Children Names
              CommonText(
                text: '$childrenNames ·',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
