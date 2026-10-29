import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/nav_screen/controller/nav_controller.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/controller/driver_role_profile_controller.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/profile_menu_row.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/refer_friend_dialog.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/widgets/switch_role_dialog.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRoleProfileScreen extends StatelessWidget {
  final bool isTab;

  const DriverRoleProfileScreen({
    super.key,
    this.isTab = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverRoleProfileController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar - matching design with back button and centered "Driver Profile" title
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
              if (Navigator.of(context).canPop()) {
                Get.back();
              } else if (Get.isRegistered<NavController>()) {
                Get.find<NavController>().changeIndex(0);
              }
            }
          },
        ),
        centerTitle: true,
        title: CommonText(
          text: controller.activeRole.toLowerCase().contains('walk')
              ? 'WalkShare Profile'
              : 'Driver Profile',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
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
      body: GetBuilder<DriverRoleProfileController>(
        builder: (_) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                12.height,

                /// 1. Hero Dark Navy Profile Card ("Robert MacDonald", "Driver", "4.9 (142 trips)")
                _buildHeroCard(controller),

                12.height,

                /// 2. Online Switch Card ("Online", "Accepting new requests")
                _buildOnlineStatusCard(controller),

                12.height,

                /// 3. Menu Group 1: Vehicle Info & Verification Documents
                _buildVehicleAndDocsGroup(controller),

                12.height,

                /// 4. Menu Group 2: Account, Support & Legal
                _buildAccountAndSupportGroup(context, controller),

                12.height,

                /// 5. Role Switcher Card ("Role: Parent", "Switch role")
                _buildRoleSwitcher(context, controller),

                14.height,

                /// 6. Log Out Button
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
  Widget _buildHeroCard(DriverRoleProfileController controller) {
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
            /// Avatar with Circular Indicator Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: _buildProfileAvatar(58.w, 58.w),
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
                        color: const Color(0xFF1B2E6C),
                        width: 2.w,
                      ),
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.toNamed(AppRoutes.driverReviews),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
                          text: '(${controller.tripCount} trips)',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF94A3B8),
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

  /// 2. Online Switch Card
  Widget _buildOnlineStatusCard(DriverRoleProfileController controller) {
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
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: controller.isOnline ? 'Online' : 'Offline',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              3.height,
              CommonText(
                text: controller.isOnline
                    ? 'Accepting new requests'
                    : 'Not accepting requests',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ],
          ),

          /// iOS Style Navy Toggle Switch
          CupertinoSwitch(
            value: controller.isOnline,
            activeColor: const Color(0xFF1B2B68),
            onChanged: (val) => controller.toggleOnline(val),
          ),
        ],
      ),
    );
  }

  /// 3. Menu Group 1: Vehicle Info & Verification Documents
  Widget _buildVehicleAndDocsGroup(DriverRoleProfileController controller) {
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
            icon: Icons.directions_car_outlined,
            title: 'Vehicle info',
            onTap: () => Get.toNamed(AppRoutes.driverVehicleInfo),
          ),
          ProfileMenuRow(
            icon: Icons.description_outlined,
            title: 'Verification documents',
            showDivider: false,
            onTap: () => Get.toNamed(AppRoutes.driverDocuments),
          ),
        ],
      ),
    );
  }

  /// 4. Menu Group 2: Refer a Friend, FAQ, Contact, Privacy, Terms, About
  Widget _buildAccountAndSupportGroup(
      BuildContext context, DriverRoleProfileController controller) {
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
            onTap: () => Get.toNamed(AppRoutes.driverReviews),
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

  /// 5. Role Switcher Card
  Widget _buildRoleSwitcher(
      BuildContext context, DriverRoleProfileController controller) {
    return GestureDetector(
      onTap: () => SwitchRoleDialog.show(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
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
            /// Dark Navy Icon Container with Layers Icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1B2B68),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.layers_rounded,
                size: 22.sp,
                color: Colors.white,
              ),
            ),

            14.width,

            /// Role Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CommonText(
                        text: 'Role: ',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                      CommonText(
                        text: controller.activeRole,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ],
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

            /// "Switch" Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
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
          ],
        ),
      ),
    );
  }

  /// 6. Log Out Button with soft red tint
  Widget _buildLogoutButton(
      BuildContext context, DriverRoleProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      child: TextButton(
        onPressed: () => controller.onLogout(context),
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFEF2F2),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: const BorderSide(
              color: Color(0xFFFEE2E2),
              width: 1.0,
            ),
          ),
        ),
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
              fontSize: 15,
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
