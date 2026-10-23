import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/bottom_nav_bar/common_bottom_bar.dart';
import 'package:home_to_school/component/image/common_image.dart';
import 'package:home_to_school/component/other_widgets/item.dart';
import 'package:home_to_school/component/pop_up/common_pop_menu.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App bar
      appBar: AppBar(
        title: const CommonText(
          text: AppString.profile,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),

      /// Body
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          final user = LocalStorage.user;
          final userName = user?.name.isNotEmpty == true
              ? user!.name
              : (LocalStorage.myName.isNotEmpty ? LocalStorage.myName : 'User');
          final userImage = user?.image ?? LocalStorage.myImage;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                /// Profile image
                16.height,

                CircleAvatar(
                  radius: 70.r,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: CommonImage(imageSrc: userImage, size: 140),
                  ),
                ),

                12.height,

                /// Name
                CommonText(
                  text: userName,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),

                24.height,

                /// Edit profile
                Item(
                  icon: Icons.person,
                  title: AppString.editProfile,
                  onTap: () => Get.toNamed(AppRoutes.editProfile),
                ),

                /// Settings
                Item(
                  icon: Icons.settings,
                  title: AppString.settings,
                  onTap: () => Get.toNamed(AppRoutes.setting),
                ),

                /// Language
                Padding(
                  padding: .symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language),

                          12.width,

                          CommonText(
                            text: controller.selectedLanguage,
                            fontSize: 16,
                          ),

                          const Spacer(),

                          PopUpMenu(
                            items: controller.languages,
                            selectedItem: [controller.selectedLanguage],
                            onTap: controller.selectLanguage,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),

                /// Logout
                const Item(
                  icon: Icons.logout,
                  title: AppString.logOut,
                  onTap: logOutPopUp,
                ),
              ],
            ),
          );
        },
      ),

      /// Bottom nav
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 3),
    );
  }
}
