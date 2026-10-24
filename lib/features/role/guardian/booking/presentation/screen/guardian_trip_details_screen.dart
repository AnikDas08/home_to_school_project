import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/guardian_trip_details_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/pickup_proof_modal.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianTripDetailsScreen extends StatelessWidget {
  const GuardianTripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuardianTripDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      /// App Bar matching Image 1: "Trip Details" with SOS button
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
          text: 'Trip Details',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: controller.onSos,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    4.width,
                    Text(
                      'SOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 1. Timeline Card
              _buildTimelineCard(),

              12.height,

              /// 2. "Pickup & drop-off photos" Card
              _buildPhotosCard(context),

              12.height,

              /// 3. Driver & Vehicle Card
              _buildDriverAndVehicleCard(controller),

              12.height,

              /// 4. Children (2) Card
              _buildChildrenCard(),

              12.height,

              /// 5. Pricing Card ($135/Month)
              _buildPricingCard(),

              12.height,

              /// 6. Additional Notes Card
              _buildNotesCard(),

              12.height,

              /// 7. Schedule Card
              _buildScheduleCard(),

              12.height,

              /// 8. Manage Booking Card
              _buildManageBookingCard(),

              20.height,

              /// 9. Bottom Actions: Track live vehicle & Cancel
              _buildActionButtons(context, controller),

              24.height,
            ],
          ),
        ),
      ),
    );
  }

  /// 1. Timeline Card with Picked up, In Transit, Scheduled
  Widget _buildTimelineCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
        children: [
          /// Stop 1: Pickup from Home
          _buildTimelineStop(
            time: '07:30 AM',
            title: 'Pickup from Home',
            subtitle: '12 Elm Street, Toronto, ON',
            status: 'Picked up',
            statusBgColor: const Color(0xFFDCFCE7),
            statusTextColor: const Color(0xFF16A34A),
            dotColor: const Color(0xFF10B981),
            isFirst: true,
          ),

          /// Connector
          _buildDottedConnector(),

          /// Stop 2: Drop at School
          _buildTimelineStop(
            time: '07:45 AM',
            title: 'Drop at School',
            subtitle: 'Greenfield International School',
            status: 'In Transit',
            statusBgColor: const Color(0xFFEFF6FF),
            statusTextColor: const Color(0xFF2563EB),
            dotColor: const Color(0xFF2563EB),
          ),

          /// Connector
          _buildDottedConnector(),

          /// Stop 3: Return to Home
          _buildTimelineStop(
            time: '01:00 PM',
            title: 'Return to Home',
            subtitle: 'Drop-off at 12 Elm Street, Toronto, ON',
            status: 'Scheduled',
            statusBgColor: const Color(0xFFF1F5F9),
            statusTextColor: const Color(0xFF64748B),
            dotColor: const Color(0xFF3B82F6),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStop({
    required String time,
    required String title,
    required String subtitle,
    required String status,
    required Color statusBgColor,
    required Color statusTextColor,
    required Color dotColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Dot indicator
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Container(
            width: 14.w,
            height: 14.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: dotColor, width: 3),
              color: Colors.white,
            ),
          ),
        ),

        12.width,

        /// Stop info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: time,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              2.height,
              CommonText(
                text: title,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
              2.height,
              CommonText(
                text: subtitle,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
                maxLines: 1,
              ),
            ],
          ),
        ),

        /// Status Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: CommonText(
            text: status,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: statusTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDottedConnector() {
    return Padding(
      padding: EdgeInsets.only(left: 6.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 2,
          height: 20.h,
          color: const Color(0xFFCBD5E1),
        ),
      ),
    );
  }

  /// 2. "Pickup & drop-off photos" Card
  Widget _buildPhotosCard(BuildContext context) {
    return GestureDetector(
      onTap: () => PickupProofModal.show(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
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
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 22.sp,
                color: const Color(0xFF1E3A8A),
              ),
            ),
            14.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Pickup & drop-off photos',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  3.height,
                  const CommonText(
                    text: 'Photos appear here at pickup and drop-off',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  /// 3. Driver & Vehicle Card
  Widget _buildDriverAndVehicleCard(GuardianTripDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
        children: [
          /// Driver Row
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: const AssetImage(AppImages.profileImage),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CommonText(
                          text: 'Tariq Ahmed',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                        4.width,
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                      ],
                    ),
                    3.height,
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 15,
                          color: Color(0xFFFBBF24),
                        ),
                        4.width,
                        const CommonText(
                          text: '4.9 (128 trips)',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Call Button
              GestureDetector(
                onTap: controller.onCallDriver,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.call_outlined,
                      size: 18,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),

              10.width,

              /// Message Button
              GestureDetector(
                onTap: controller.onMessageDriver,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 18,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
            ],
          ),

          14.height,
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          14.height,

          /// Vehicle Row
          Row(
            children: [
              Container(
                width: 44.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(
                  Icons.directions_car_filled_rounded,
                  color: Color(0xFF64748B),
                  size: 24,
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: 'Toyota Sienna',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                    2.height,
                    const CommonText(
                      text: 'SCH-4091 • White • 4 Seater',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 4. Children (2) Card
  Widget _buildChildrenCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.people_alt_outlined,
              size: 20.sp,
              color: const Color(0xFF1E3A8A),
            ),
          ),
          12.width,
          Expanded(
            child: const CommonText(
              text: 'Children (2)',
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(
            width: 48.w,
            height: 28.w,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundImage: const AssetImage(AppImages.profileImage),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundImage: const AssetImage(AppImages.profileImage),
                  ),
                ),
              ],
            ),
          ),
          8.width,
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF94A3B8),
            size: 20,
          ),
        ],
      ),
    );
  }

  /// 5. Pricing Card
  Widget _buildPricingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          const CommonText(
            text: '\$135/Month',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
          4.height,
          const CommonText(
            text: 'Agreed rate • Paid directly to Tariq',
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  /// 6. Additional Notes Card
  Widget _buildNotesCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              size: 20.sp,
              color: const Color(0xFF1E3A8A),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Additional Notes',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                4.height,
                const CommonText(
                  text:
                      'Gate 2 (Junior Wing Pickup) • Arman & Emma handover requires PIN verification. Driver will wait 5 mins at home',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 7. Schedule Card
  Widget _buildScheduleCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              size: 20.sp,
              color: const Color(0xFF1E3A8A),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Schedule',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                2.height,
                const CommonText(
                  text: 'Repeats every Mon - Fri • Until Dec 31, 2026',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF94A3B8),
            size: 20,
          ),
        ],
      ),
    );
  }

  /// 8. Manage Booking Card
  Widget _buildManageBookingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.edit_outlined,
              size: 20.sp,
              color: const Color(0xFF1E3A8A),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Manage Booking',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                2.height,
                const CommonText(
                  text: 'Rate agreed: \$135/week • Direct payment',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF94A3B8),
            size: 20,
          ),
        ],
      ),
    );
  }

  /// 9. Bottom Actions: Track live vehicle & Cancel
  Widget _buildActionButtons(
      BuildContext context, GuardianTripDetailsController controller) {
    return Column(
      children: [
        /// Track live vehicle (Navy blue)
        GestureDetector(
          onTap: controller.onTrackLiveVehicle,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(14.r),
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
                  Icons.location_on_outlined,
                  size: 19.sp,
                  color: Colors.white,
                ),
                8.width,
                const CommonText(
                  text: 'Track live vehicle',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

        12.height,

        /// Cancel This Booking (Light red outlined)
        GestureDetector(
          onTap: () => controller.onCancelBooking(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: const Color(0xFFFEE2E2),
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
                  text: 'Cancel This Booking',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFEF4444),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
