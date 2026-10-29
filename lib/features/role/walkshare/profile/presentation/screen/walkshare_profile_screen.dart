import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/profile_menu_row.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/refer_friend_dialog.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/controller/walkshare_profile_controller.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareProfileScreen extends StatelessWidget {
  final bool isTab;

  const WalkshareProfileScreen({
    super.key,
    this.isTab = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareProfileController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar: "WalkShare Profile"
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
            if (isTab) {
              if (Get.isRegistered<NavController>()) {
                Get.find<NavController>().changeIndex(0);
              } else if (Navigator.of(context).canPop()) {
                Get.back();
              }
            } else {
              Get.back();
            }
          },
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'WalkShare Profile',
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

      /// Body Content matching Image 1
      body: GetBuilder<WalkshareProfileController>(
        builder: (_) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                12.height,

                /// 1. Hero Profile Card (Robert MacDonald, WalkShare Guide)
                _buildHeroCard(controller),

                12.height,

                /// 2. Online Switch Card
                _buildOnlineStatusCard(controller),

                12.height,

                /// 3. Documents & Payment Group
                _buildVerificationAndPaymentGroup(controller),

                12.height,

                /// 4. Reviews, Support & Legal Group
                _buildMenuAndSupportGroup(context, controller),

                12.height,

                /// 5. Role Switcher Card (Role: WalkShare)
                _buildRoleSwitcher(context, controller),

                16.height,

                /// 6. Log Out Button (Red outlined card)
                _buildLogoutButton(context, controller),

                30.height,
              ],
            ),
          );
        },
      ),
    );
  }

  /// 1. Hero Profile Card with Navy Blue Gradient
  Widget _buildHeroCard(WalkshareProfileController controller) {
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
              Color(0xFF0F172A), // Deep navy black
              Color(0xFF1E3A8A), // Rich royal navy
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x181E3A8A),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Avatar with Circular Indicator Dot
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: _buildProfileAvatar(56.w, 56.w),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF94A3B8),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0F172A),
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            14.width,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CommonText(
                          text: controller.name,
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      6.width,
                      Icon(
                        Icons.verified_rounded,
                        size: 16.sp,
                        color: const Color(0xFF38BDF8),
                      ),
                    ],
                  ),
                  4.height,
                  CommonText(
                    text: controller.roleDescription,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  6.height,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.toNamed(AppRoutes.walkshareReviews),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 15.sp,
                          color: const Color(0xFFFBBF24),
                        ),
                        4.width,
                        CommonText(
                          text:
                              '${controller.rating} (${controller.walkCount} trips)',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        6.width,
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 14.sp,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  /// 2. Online Switch Card
  Widget _buildOnlineStatusCard(WalkshareProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Online',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                3.height,
                const CommonText(
                  text: 'Accepting new requests',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: controller.isOnline,
            activeColor: const Color(0xFF1B2B68),
            onChanged: controller.toggleOnline,
          ),
        ],
      ),
    );
  }

  /// 3. Documents & Payment Group matching Image 1
  Widget _buildVerificationAndPaymentGroup(
      WalkshareProfileController controller) {
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
            icon: Icons.assignment_turned_in_outlined,
            title: 'Verification documents',
            onTap: () => Get.toNamed(AppRoutes.walkshareDocuments),
          ),
          ProfileMenuRow(
            icon: Icons.receipt_long_outlined,
            title: 'Billing & Transactions',
            showDivider: false,
            onTap: () => Get.toNamed(AppRoutes.billingAndTransactions),
          ),
        ],
      ),
    );
  }

  /// 4. Menu & Support Group matching Image 1
  Widget _buildMenuAndSupportGroup(
      BuildContext context, WalkshareProfileController controller) {
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
            icon: Icons.star_outline_rounded,
            title: 'Ratings & reviews',
            onTap: () => Get.toNamed(AppRoutes.walkshareReviews),
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
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
          ),
          ProfileMenuRow(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => Get.toNamed(AppRoutes.termsOfService),
          ),
          ProfileMenuRow(
            icon: Icons.info_outline_rounded,
            title: 'About Home2School',
            showDivider: false,
            onTap: () => controller.onAboutTap(context),
          ),
        ],
      ),
    );
  }

  /// 5. Role Switcher Card matching Image 1
  Widget _buildRoleSwitcher(
      BuildContext context, WalkshareProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FD),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1B2B68),
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.layers_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          14.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'Role: ${controller.activeRole}',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                3.height,
                const CommonText(
                  text: 'Switch role',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.onSwitchRole(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 1.0,
                ),
              ),
              child: const CommonText(
                text: 'Switch',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 6. Log Out Button matching Image 1
  Widget _buildLogoutButton(
      BuildContext context, WalkshareProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () => controller.onLogout(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFFFEE2E2),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                color: const Color(0xFFEF4444),
                size: 18.sp,
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
      ),
    );
  }

  /// Helper: Build Profile Avatar
  Widget _buildProfileAvatar(double width, double height) {
    final imagePath = LocalStorage.profileImage;
    if (imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        return Image.network(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _defaultProfileAvatar(width, height),
        );
      } else {
        final file = File(imagePath);
        if (file.existsSync()) {
          return Image.file(
            file,
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _defaultProfileAvatar(width, height),
          );
        }
      }
    }
    return _defaultProfileAvatar(width, height);
  }

  Widget _defaultProfileAvatar(double width, double height) {
    return Image.asset(
      AppImages.profileImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: const Color(0xFFE2E8F0),
        child: const Icon(Icons.person, color: Color(0xFF64748B)),
      ),
    );
  }
}
