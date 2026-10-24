import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/home/presentation/controller/driver_home_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverQuickActionsWidget extends StatelessWidget {
  const DriverQuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverHomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          text: 'Quick Actions',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
          textAlign: TextAlign.start,
        ),

        14.height,

        /// Row with "Requests" and "Availability"
        Row(
          children: [
            /// 1. Requests Card
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: controller.onRequestsTap,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Light Blue Rounded Box with Requests/Seat Icon
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.inbox_outlined,
                            color: const Color(0xFF2563EB),
                            size: 22.sp,
                          ),
                        ),
                        10.height,
                        const CommonText(
                          text: 'Requests',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            12.width,

            /// 2. Availability Card
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: controller.onAvailabilityTap,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Light Orange Rounded Box with Clock Icon
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.access_time_rounded,
                            color: const Color(0xFFEA580C),
                            size: 22.sp,
                          ),
                        ),
                        10.height,
                        const CommonText(
                          text: 'Availability',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
