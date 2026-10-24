import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/controller/driver_request_details_controller.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/widgets/driver_request_earnings_card.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/widgets/driver_request_notes_card.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/widgets/driver_request_parent_card.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/widgets/driver_request_riders_card.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/widgets/driver_request_route_card.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/widgets/driver_request_schedule_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestDetailsScreen extends StatelessWidget {
  const DriverRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverRequestDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      /// App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: Color(0xFF0F172A),
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Request',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body Content
      body: SafeArea(
        child: GetBuilder<DriverRequestDetailsController>(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                children: [
                  /// 1. Parent Card
                  DriverRequestParentCard(
                    name: controller.parentName,
                    role: controller.parentRole,
                    isVerified: controller.isVerified,
                    avatarUrl: controller.parentAvatarUrl,
                    onChat: controller.openChat,
                  ),

                  12.height,

                  /// 2. Student Riders Card
                  DriverRequestRidersCard(
                    riders: controller.riders,
                  ),

                  12.height,

                  /// 3. Route Card
                  DriverRequestRouteCard(
                    pickupAddress: controller.pickupAddress,
                    pickupLabel: controller.pickupLabel,
                    destinationAddress: controller.destinationAddress,
                    destinationLabel: controller.destinationLabel,
                  ),

                  12.height,

                  /// 4. Schedule Card
                  DriverRequestScheduleCard(
                    morningTitle: controller.morningTitle,
                    morningTime: controller.morningTime,
                    afternoonTitle: controller.afternoonTitle,
                    afternoonTime: controller.afternoonTime,
                  ),

                  12.height,

                  /// 5. Special Notes Card
                  DriverRequestNotesCard(
                    notes: controller.specialNotes,
                  ),

                  12.height,

                  /// 6. Trip Earnings & Payment Card
                  DriverRequestEarningsCard(
                    amount: controller.earningsAmount,
                    period: controller.earningsPeriod,
                  ),

                  12.height,

                  /// 7. Compliance Notice Box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.0,
                      ),
                    ),
                    child: CommonText(
                      text: controller.complianceNotice,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  20.height,

                  /// 8. Accept Request Button
                  GestureDetector(
                    onTap: controller.acceptRequest,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B68),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1B2B68).withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 19.sp,
                            color: Colors.white,
                          ),
                          8.width,
                          const CommonText(
                            text: 'Accept Request',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  12.height,

                  /// 9. Decline Request Button
                  GestureDetector(
                    onTap: controller.declineRequest,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFFCA5A5),
                          width: 1.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            size: 19.sp,
                            color: const Color(0xFFDC2626),
                          ),
                          8.width,
                          const CommonText(
                            text: 'Decline Request',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFDC2626),
                          ),
                        ],
                      ),
                    ),
                  ),

                  24.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
