import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/controller/guardian_profile_controller.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/profile_menu_row.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/refer_friend_dialog.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianProfileScreen extends StatelessWidget {
  const GuardianProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuardianProfileController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar - matching design with back icon and centered title
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
          onPressed: () {
            if (Get.isRegistered<NavController>()) {
              Get.find<NavController>().changeIndex(0);
            } else if (Navigator.of(context).canPop()) {
              Get.back();
            }
          },
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Parent Profile',
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
      body: GetBuilder<GuardianProfileController>(
        builder: (_) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                12.height,

                /// 1. Hero Dark Navy Profile Card
                _buildHeroCard(controller),

                10.height,

                /// 2. Menu Group 1: Family & Safety
                _buildFamilyGroup(controller),

                10.height,

                /// 3. Menu Group 2: Account, Support & Legal
                _buildAccountGroup(context, controller),

                10.height,

                /// 4. Role Switcher Card
                _buildRoleSwitcher(context, controller),

                12.height,

                /// 5. Log Out Button
                _buildLogoutButton(context, controller),

                30.height,
              ],
            ),
          );
        },
      ),
    );
  }

  /// 1. Hero Profile Card with Deep Navy Gradient
  Widget _buildHeroCard(GuardianProfileController controller) {
    return GestureDetector(
      onTap: controller.onEditProfile,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A1435),
              Color(0xFF1B2E6C),
              Color(0xFF142456),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x181B2E6C),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Avatar with Orange Edit Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: _buildProfileAvatar(58.w, 58.w),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEA580C),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 10.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            14.width,

            /// Name, Role, Rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CommonText(
                          text: controller.name,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      6.width,
                      Icon(
                        Icons.check_circle_rounded,
                        size: 16.sp,
                        color: const Color(0xFF38BDF8),
                      ),
                    ],
                  ),
                  4.height,
                  CommonText(
                    text: controller.roleDescription,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFCBD5E1),
                  ),
                  5.height,
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14.sp,
                        color: const Color(0xFFF59E0B),
                      ),
                      4.width,
                      CommonText(
                        text: controller.rating,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF59E0B),
                      ),
                      4.width,
                      CommonText(
                        text: '(${controller.reviewCount} reviews)',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF94A3B8),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Trailing Chevron
            Icon(
              Icons.chevron_right_rounded,
              size: 24.sp,
              color: const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  /// 2. Menu Group 1: Family & Safety
  Widget _buildFamilyGroup(GuardianProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuRow(
            icon: Icons.people_alt_outlined,
            title: 'My Children',
            badgeText: '${controller.childrenCount}',
            onTap: () => Get.toNamed(AppRoutes.myChildren),
          ),
          ProfileMenuRow(
            icon: Icons.location_on_outlined,
            title: 'Saved Locations',
            onTap: () => Get.toNamed(AppRoutes.savedLocations),
          ),
          ProfileMenuRow(
            icon: Icons.favorite_border_rounded,
            title: 'Favourites',
            onTap: () => Get.toNamed(AppRoutes.favourites),
          ),
          ProfileMenuRow(
            icon: Icons.shield_outlined,
            title: 'Emergency Contacts',
            showDivider: false,
            onTap: () => Get.toNamed(AppRoutes.emergencyContacts),
          ),
        ],
      ),
    );
  }

  /// 3. Menu Group 2: Account, Support & Legal
  Widget _buildAccountGroup(
      BuildContext context, GuardianProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuRow(
            icon: Icons.receipt_long_outlined,
            title: 'Billing & Transactions',
            onTap: () => Get.toNamed(AppRoutes.billingAndTransactions),
          ),
          ProfileMenuRow(
            icon: Icons.card_giftcard_rounded,
            title: 'Refer a Friend',
            onTap: () => ReferFriendDialog.show(context),
          ),
          ProfileMenuRow(
            icon: Icons.help_outline_rounded,
            title: 'FAQ',
            onTap: () => Get.toNamed(AppRoutes.faq),
          ),
          ProfileMenuRow(
            icon: Icons.headset_mic_outlined,
            title: 'Contact Support',
            onTap: () => Get.toNamed(AppRoutes.contactSupport),
          ),
          ProfileMenuRow(
            icon: Icons.security_outlined,
            title: 'Privacy Policy',
            onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
          ),
          ProfileMenuRow(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => Get.toNamed(AppRoutes.termsOfServices),
          ),
          ProfileMenuRow(
            icon: Icons.info_outline_rounded,
            title: 'About Home2School',
            showDivider: false,
            onTap: () => Get.toNamed(AppRoutes.about),
          ),
        ],
      ),
    );
  }

  /// 4. Role Switcher Card
  Widget _buildRoleSwitcher(
      BuildContext context, GuardianProfileController controller) {
    return GestureDetector(
      onTap: () => SwitchRoleDialog.show(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4FD),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE0E7FF),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            /// Layers Icon Box
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1B2B68),
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.layers_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),

            12.width,

            /// Role Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Role: ${controller.activeRole}',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  2.height,
                  const CommonText(
                    text: 'Switch role',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            ),

            /// Switch Button
            GestureDetector(
              onTap: () => SwitchRoleDialog.show(context),
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: const CommonText(
                text: 'Switch',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  /// 5. Log Out Button
  Widget _buildLogoutButton(
    BuildContext context,
    GuardianProfileController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.onLogout(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(vertical: 14.h),
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
              Icons.logout_rounded,
              size: 18.sp,
              color: const Color(0xFFEF4444),
            ),
            8.width,
            const CommonText(
              text: 'Log Out',
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFFEF4444),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(double width, double height) {
    if (LocalStorage.myImage.isNotEmpty) {
      final file = File(LocalStorage.myImage);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      }
    }
    return Image.asset(
      AppImages.profileImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => CircleAvatar(
        radius: (width / 2).r,
        backgroundColor: const Color(0xFFEFF6FF),
        child: Icon(
          Icons.person,
          size: 30.sp,
          color: const Color(0xFF1B2B68),
        ),
      ),
    );
  }
}
