import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/available_providers_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverProfileScreen extends StatefulWidget {
  final ProviderModel? provider;

  const DriverProfileScreen({super.key, this.provider});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider ??
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
          text: 'Driver Profile',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        actions: [
          /// Favorite Heart Button
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () => setState(() => _isFavorite = !_isFavorite),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  _isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 19.sp,
                  color: _isFavorite
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF64748B),
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

      /// Body
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                child: Column(
                  children: [
                    /// 1. Avatar with Verified Shield Badge
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x12000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(44.r),
                              child: Image.asset(
                                AppImages.profileImage,
                                width: 88.w,
                                height: 88.w,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => CircleAvatar(
                                  radius: 44.r,
                                  backgroundColor: const Color(0xFFEFF6FF),
                                  child: Icon(
                                    Icons.person,
                                    size: 48.sp,
                                    color: const Color(0xFF1B2B68),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// Shield Verified Badge at bottom right of avatar
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              width: 24.w,
                              height: 24.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0284C7),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.shield_rounded,
                                size: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    12.height,

                    /// Name and Verified Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: provider.name,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        6.width,
                        Icon(
                          Icons.check_circle_rounded,
                          size: 18.sp,
                          color: const Color(0xFF38BDF8),
                        ),
                      ],
                    ),

                    4.height,

                    /// Rating, Reviews, and Distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16.sp,
                          color: const Color(0xFFF59E0B),
                        ),
                        4.width,
                        CommonText(
                          text: '${provider.rating} (128 reviews)',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF59E0B),
                        ),
                        6.width,
                        const CommonText(
                          text: '•',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                        6.width,
                        CommonText(
                          text: '${provider.distanceKm} km away',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ],
                    ),

                    20.height,

                    /// 2. Stats Section (4+ Yrs, 500+ Trips, 99.8% On-Time)
                    _buildStatsRow(),

                    18.height,

                    /// 3. Vehicle Details Card
                    _buildVehicleCard(provider),

                    14.height,

                    /// 4. Overview Card (Service Area & Schedule)
                    _buildOverviewCard(),

                    16.height,

                    /// 5. About Driver Section
                    _buildAboutSection(provider.name),

                    16.height,
                  ],
                ),
              ),
            ),

            /// Bottom Action Bar (Message + Request Booking)
            _buildBottomActionBar(provider),
          ],
        ),
      ),
    );
  }

  /// Stats Row with 3 Columns & Dividers
  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem('4+ Yrs', 'Experience'),
        _buildVerticalDivider(),
        _buildStatItem('500+', 'Trips Completed'),
        _buildVerticalDivider(),
        _buildStatItem('99.8%', 'On-Time Rate'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          CommonText(
            text: value,
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1B2B68),
          ),
          4.height,
          CommonText(
            text: label,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 28.h,
      color: const Color(0xFFE2E8F0),
    );
  }

  /// Vehicle Card with 2x2 Feature Chips
  Widget _buildVehicleCard(ProviderModel provider) {
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
          /// Top: Icon + Title + Subtitle
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.directions_car_rounded,
                  size: 24.sp,
                  color: const Color(0xFF1B2B68),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: '${provider.vehicle} (2023)',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    3.height,
                    const CommonText(
                      text: 'Clean & Audited School Commute Vehicle',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
            ],
          ),

          14.height,

          /// 2x2 Feature Pills
          Row(
            children: [
              _buildFeaturePill(Icons.people_outline_rounded, '${provider.seats} seats available'),
              10.width,
              _buildFeaturePill(Icons.tag_rounded, 'Plate: SCH-4091'),
            ],
          ),

          10.height,

          Row(
            children: [
              _buildFeaturePill(Icons.shield_outlined, 'Booster Seats Equipped'),
              10.width,
              _buildFeaturePill(Icons.lock_outline_rounded, 'Child Door Locks'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 15.sp,
              color: const Color(0xFF64748B),
            ),
            6.width,
            Expanded(
              child: CommonText(
                text: label,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Overview Card (Service Area & Schedule)
  Widget _buildOverviewCard() {
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
            text: 'Overview',
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),

          12.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 17.sp,
                    color: const Color(0xFF64748B),
                  ),
                  8.width,
                  const CommonText(
                    text: 'Service area',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
              const CommonText(
                text: 'Greenfield / Midtown',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ],
          ),

          12.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16.sp,
                    color: const Color(0xFF64748B),
                  ),
                  8.width,
                  const CommonText(
                    text: 'Schedule',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
              const CommonText(
                text: 'Mon-Fri - AM & PM',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// About Section
  Widget _buildAboutSection(String name) {
    final firstName = name.split(' ').first.toUpperCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'ABOUT $firstName',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF64748B),
        ),

        8.height,

        Container(
          padding: EdgeInsets.only(left: 12.w),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF1B2B68),
                width: 3.5,
              ),
            ),
          ),
          child: const CommonText(
            text:
                'Experienced school transport provider with a strong focus on child safety. Verified background check, booster seat equipped, and CPR certified.',
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF475569),
            textAlign: TextAlign.start,
            maxLines: 4,
          ),
        ),
      ],
    );
  }

  /// Bottom Sticky Action Bar
  Widget _buildBottomActionBar(ProviderModel provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Message Button
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.chat),
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 17.sp,
                      color: const Color(0xFF0F172A),
                    ),
                    8.width,
                    const CommonText(
                      text: 'Message',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ],
                ),
              ),
            ),
          ),

          12.width,

          /// Request Booking Button
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.bookingSummary,
                arguments: provider,
              ),
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1B2B68).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CommonText(
                      text: 'Request Booking',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    4.width,
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
