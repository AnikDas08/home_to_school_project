import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/requests/presentation/controller/walkshare_requests_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareRequestsScreen extends StatelessWidget {
  const WalkshareRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareRequestsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      /// App Bar: "Requests"
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
          text: 'Requests',
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
        child: GetBuilder<WalkshareRequestsController>(
          builder: (_) {
            if (controller.requests.isEmpty) {
              return const Center(
                child: CommonText(
                  text: 'No pending requests',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: List.generate(
                  controller.requests.length,
                  (index) {
                    final item = controller.requests[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: _buildRequestCard(controller, item),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRequestCard(
      WalkshareRequestsController controller, WalkshareRequestItem item) {
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
          /// Clickable Content Area
          GestureDetector(
            onTap: () => controller.onRequestItemTap(item),
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 1. Top Header: Initials Avatar, Name & Kids, Price & Chevron
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: item.parentName,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          3.height,
                          CommonText(
                            text: item.childrenInfo,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    8.width,

                    Row(
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
                          size: 16.sp,
                          color: const Color(0xFF1B2B68),
                        ),
                      ],
                    ),
                  ],
                ),

                16.height,

                /// 2. Route Timeline
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1B2B68),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 1.5.w,
                          height: 18.h,
                          color: const Color(0xFFCBD5E1),
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          size: 12.sp,
                          color: const Color(0xFFEA580C),
                        ),
                      ],
                    ),
                    10.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: item.pickupAddress,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0F172A),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          10.height,
                          CommonText(
                            text: item.destinationAddress,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0F172A),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                14.height,

                /// 3. Date & Time Row
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                    6.width,
                    CommonText(
                      text: item.scheduleDays,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                    ),
                    18.width,
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                    6.width,
                    CommonText(
                      text: item.scheduleTime,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                    ),
                  ],
                ),

                12.height,

                /// 4. Badges (e.g. Recurring / One-time, 2 seats / 1 seat)
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.sync_rounded,
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.group_outlined,
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

          /// 5. Accept & Decline Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.acceptRequest(item.id),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2B68),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 16.sp,
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

              10.width,

              Expanded(
                child: GestureDetector(
                  onTap: () => controller.declineRequest(item.id),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1EB),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          size: 16.sp,
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
            ],
          ),
        ],
      ),
    );
  }
}
