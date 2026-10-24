import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/available_providers_controller.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookingSummaryScreen extends StatelessWidget {
  final ProviderModel? provider;

  const BookingSummaryScreen({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    final driver = provider ??
        (Get.arguments is ProviderModel ? Get.arguments as ProviderModel : null) ??
        const ProviderModel(
          id: '1',
          name: 'Tariq Ahmed',
          isVerified: true,
          rating: 4.9,
          distanceKm: 0.8,
          area: 'Greenfield',
          vehicle: 'Toyota Sienna',
          seats: 4,
          gender: 'Male',
        );

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
          text: 'Booking Summary',
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              /// 1. Trip Information Card
              _buildTripInfoCard(driver),

              14.height,

              /// 2. Pricing Summary Card
              _buildPricingSummaryCard(),

              16.height,

              /// 3. Notice with Shield Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 15.sp,
                    color: const Color(0xFF64748B),
                  ),
                  6.width,
                  const CommonText(
                    text:
                        'You will not be charged until provider accepts your request.',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),

              20.height,

              /// 4. Send Booking Request Button
              GestureDetector(
                onTap: () {
                  // 1. Switch bottom nav to Bookings tab (index 1)
                  if (Get.isRegistered<NavController>()) {
                    Get.find<NavController>().changeIndex(1);
                  }

                  // 2. Safely pop back to NavScreen (never pops past root route)
                  if (Navigator.of(context).canPop()) {
                    Get.until((route) =>
                        route.settings.name == AppRoutes.navScreen ||
                        route.settings.name == AppRoutes.homeNav ||
                        route.isFirst);
                  } else {
                    Get.offAllNamed(AppRoutes.navScreen);
                  }

                  // 3. Show success notification on the destination screen
                  AppSnackbar.success(
                    title: 'Request Sent',
                    message:
                        'Your booking request was sent to ${driver.name}. You will be notified once accepted.',
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 50.h,
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
                  child: const CommonText(
                    text: 'Send Booking Request',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              14.height,

              /// 5. Edit Trip Details Link
              GestureDetector(
                onTap: () => Get.back(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const CommonText(
                    text: 'Edit Trip Details',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),

              20.height,
            ],
          ),
        ),
      ),
    );
  }

  /// Trip Information Card (matching Image 2)
  Widget _buildTripInfoCard(ProviderModel driver) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: 'Trip Information',
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),

          14.height,

          _buildInfoRow('Children', 'Arman Khan & Emma Khan (2)'),
          12.height,
          _buildInfoRow('Trip Direction', '⇄ Round Trip'),
          12.height,
          _buildInfoRow('Outbound Leg', 'Home → School (07:30 AM)'),
          12.height,
          _buildInfoRow('Return Leg', 'School → Home (01:00 PM)'),
          12.height,
          _buildInfoRow('Frequency', 'Recurring (Mon - Fri Commute)'),
          12.height,
          _buildInfoRow('Provider', '${driver.name} (${driver.vehicle})'),
        ],
      ),
    );
  }

  /// Pricing Summary Card (matching Image 2)
  Widget _buildPricingSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: 'Pricing Summary',
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),

          14.height,

          _buildPricingRow('Weekly Base Rate', '\$240.00'),
          12.height,
          _buildPricingRow(
            'Multi-Child Discount (2nd child 20% off)',
            '-\$24.00',
            valueColor: const Color(0xFF10B981),
          ),
          12.height,
          _buildPricingRow(
            'Service Fee',
            '\$14.00',
            valueColor: const Color(0xFF10B981),
          ),

          14.height,

          const Divider(
            color: Color(0xFFF1F5F9),
            thickness: 1,
            height: 1,
          ),

          14.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: 'Total Amount',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
              const CommonText(
                text: '\$224.00 / week',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1B2B68),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontSize: 12.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
        ),
        8.width,
        Flexible(
          child: CommonText(
            text: value,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildPricingRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CommonText(
            text: label,
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF64748B),
            textAlign: TextAlign.start,
          ),
        ),
        8.width,
        CommonText(
          text: value,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: valueColor ?? const Color(0xFF0F172A),
        ),
      ],
    );
  }
}
