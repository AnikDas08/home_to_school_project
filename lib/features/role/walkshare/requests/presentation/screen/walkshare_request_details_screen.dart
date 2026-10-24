import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/requests/presentation/controller/walkshare_request_details_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareRequestDetailsScreen extends StatelessWidget {
  const WalkshareRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareRequestDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      /// App Bar: "Request"
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

      /// Body Content matching WalkShare Request Details
      body: SafeArea(
        child: GetBuilder<WalkshareRequestDetailsController>(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                children: [
                  /// 1. Parent Card (Amanda Roy, Parent/Guardian, Verified, Chat)
                  _buildParentCard(controller),

                  12.height,

                  /// 2. Student Riders Card (Noah Roy & Olivia Roy)
                  _buildRidersCard(controller.riders),

                  12.height,

                  /// 3. Route Card (18 Maple Avenue -> Greenfield International)
                  _buildRouteCard(controller),

                  12.height,

                  /// 4. Schedule Card (07:45 AM & 03:10 PM)
                  _buildScheduleCard(controller),

                  12.height,

                  /// 5. Special Notes Card
                  _buildNotesCard(controller.specialNotes),

                  12.height,

                  /// 6. Trip Earnings & Payment Card ($120 / Month)
                  _buildEarningsCard(
                    controller.earningsAmount,
                    controller.earningsPeriod,
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

                  /// 8. Accept Request Button (Navy Blue)
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

                  /// 9. Decline Request Button (Outlined Red)
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
                          color: const Color(0xFFEF4444).withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            size: 18.sp,
                            color: const Color(0xFFEF4444),
                          ),
                          8.width,
                          const CommonText(
                            text: 'Decline Request',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFEF4444),
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

  /// 1. Parent Profile Card
  Widget _buildParentCard(WalkshareRequestDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: const Color(0xFFE2E8F0),
            backgroundImage: controller.parentAvatarUrl.isNotEmpty
                ? NetworkImage(controller.parentAvatarUrl)
                : null,
            child: controller.parentAvatarUrl.isEmpty
                ? const Icon(Icons.person, color: Color(0xFF64748B))
                : null,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CommonText(
                      text: controller.parentName,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    6.width,
                    if (controller.isVerified)
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: Color(0xFF1E3A8A),
                      ),
                  ],
                ),
                4.height,
                CommonText(
                  text: controller.parentRole,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: controller.openChat,
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 2. Student Riders Card
  Widget _buildRidersCard(List<StudentRiderModel> riders) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Row(
            children: [
              const Icon(
                Icons.people_alt_outlined,
                size: 18,
                color: Color(0xFF475569),
              ),
              8.width,
              CommonText(
                text: 'STUDENT RIDERS (${riders.length})',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
              ),
            ],
          ),
          14.height,
          Column(
            children: List.generate(riders.length, (index) {
              final rider = riders[index];
              final isLast = index == riders.length - 1;

              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: const Color(0xFFE2E8F0),
                        backgroundImage: rider.avatarUrl.isNotEmpty
                            ? NetworkImage(rider.avatarUrl)
                            : null,
                        child: rider.avatarUrl.isEmpty
                            ? CommonText(
                                text: rider.initials.isNotEmpty
                                    ? rider.initials
                                    : rider.name.characters.first,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF334155),
                              )
                            : null,
                      ),
                      12.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: rider.name,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                            3.height,
                            CommonText(
                              text: rider.grade,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isLast) ...[
                    10.height,
                    const Divider(
                      height: 1,
                      thickness: 0.8,
                      color: Color(0xFFF1F5F9),
                    ),
                    10.height,
                  ],
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 3. Route Card
  Widget _buildRouteCard(WalkshareRequestDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Color(0xFF475569),
              ),
              8.width,
              const CommonText(
                text: 'ROUTE',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ],
          ),
          14.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1E3A8A),
                        width: 3.5,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 36.h,
                    color: const Color(0xFFCBD5E1),
                  ),
                  const Icon(
                    Icons.location_on_rounded,
                    size: 18,
                    color: Color(0xFFEA580C),
                  ),
                ],
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: controller.pickupAddress,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    2.height,
                    CommonText(
                      text: controller.pickupLabel,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                    22.height,
                    CommonText(
                      text: controller.destinationAddress,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    2.height,
                    CommonText(
                      text: controller.destinationLabel,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
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

  /// 4. Schedule Card
  Widget _buildScheduleCard(WalkshareRequestDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 18,
                color: Color(0xFF475569),
              ),
              8.width,
              const CommonText(
                text: 'SCHEDULE',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ],
          ),
          14.height,
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.wb_sunny_outlined,
                        size: 20,
                        color: Color(0xFFEA580C),
                      ),
                      10.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: controller.morningTitle,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                            3.height,
                            CommonText(
                              text: controller.morningTime,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.nightlight_outlined,
                        size: 20,
                        color: Color(0xFF1E3A8A),
                      ),
                      10.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: controller.afternoonTitle,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                            3.height,
                            CommonText(
                              text: controller.afternoonTime,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 5. Special Notes Card
  Widget _buildNotesCard(String notes) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                size: 18,
                color: Color(0xFF475569),
              ),
              8.width,
              const CommonText(
                text: 'SPECIAL NOTES',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ],
          ),
          12.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.people_outline_rounded,
                size: 18,
                color: Color(0xFF64748B),
              ),
              10.width,
              Expanded(
                child: CommonText(
                  text: notes,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF334155),
                  textAlign: TextAlign.start,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 6. Trip Earnings & Payment Card
  Widget _buildEarningsCard(String amount, String period) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Row(
            children: [
              const Icon(
                Icons.credit_card_outlined,
                size: 18,
                color: Color(0xFF475569),
              ),
              8.width,
              const CommonText(
                text: 'TRIP EARNINGS & PAYMENT',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ],
          ),
          12.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CommonText(
                text: amount,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
              6.width,
              CommonText(
                text: period,
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
