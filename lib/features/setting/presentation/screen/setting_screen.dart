import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/other_widgets/item.dart';
import 'package:home_to_school/component/pop_up/common_pop_menu.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _pushNotifications = true;
  bool _transitAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const CommonText(
          text: AppString.settings,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Account & Security',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
            12.height,
            Item(
              icon: Icons.lock_outline_rounded,
              title: AppString.changePassword,
              onTap: () => Get.toNamed(AppRoutes.changePassword),
            ),

            20.height,
            const CommonText(
              text: 'Preferences',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
            12.height,

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(
                        text: 'Push Notifications',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      Switch.adaptive(
                        value: _pushNotifications,
                        activeTrackColor: AppColors.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _pushNotifications = val;
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(
                        text: 'Bus Proximity Alerts',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      Switch.adaptive(
                        value: _transitAlerts,
                        activeTrackColor: AppColors.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _transitAlerts = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            20.height,
            const CommonText(
              text: 'Legal & Info',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
            12.height,

            Item(
              icon: Icons.privacy_tip_outlined,
              title: AppString.privacyPolicy,
              onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
            ),
            Item(
              icon: Icons.description_outlined,
              title: AppString.termsOfServices,
              onTap: () => Get.toNamed(AppRoutes.termsOfServices),
            ),
            Item(
              icon: Icons.info_outline,
              title: 'About Home to School',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: AppString.appName,
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.directions_bus_rounded,
                    size: 40,
                    color: AppColors.primaryColor,
                  ),
                  children: const [
                    Text(
                      'Home to School is a student transportation management and tracking app designed for parent and school safety.',
                    ),
                  ],
                );
              },
            ),

            24.height,
            const Item(
              icon: Icons.logout,
              title: AppString.logOut,
              onTap: logOutPopUp,
            ),
          ],
        ),
      ),
    );
  }
}
