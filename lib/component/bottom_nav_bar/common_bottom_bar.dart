import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/log/app_log.dart';

final List<Widget> _unselectedIcons = [
  const Icon(Icons.home_outlined, color: AppColors.black),
  const Icon(Icons.notifications_outlined, color: AppColors.black),
  const Icon(Icons.chat_bubble_outline, color: AppColors.black),
  const Icon(Icons.person_outline, color: AppColors.black),
];

final List<Widget> _selectedIcons = [
  const Icon(Icons.home, color: AppColors.primaryColor),
  const Icon(Icons.notifications, color: AppColors.primaryColor),
  const Icon(Icons.chat_bubble, color: AppColors.primaryColor),
  const Icon(Icons.person, color: AppColors.primaryColor),
];

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: .center,
      padding: .all(12.sp),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: .only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: List.generate(_unselectedIcons.length, (index) {
          return InkWell(
            onTap: () => onTap(index),
            child: Container(
              margin: .all(12.sp),
              child: Column(
                children: [
                  index == currentIndex
                      ? _selectedIcons[index]
                      : _unselectedIcons[index],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> onTap(int index) async {
    appLog(currentIndex, source: 'common bottom bar');

    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.home);
        break;

      case 1:
        Get.toNamed(AppRoutes.notifications);
        break;

      case 2:
        Get.toNamed(AppRoutes.chat);
        break;

      case 3:
        Get.toNamed(AppRoutes.profile);
        break;

      default:
        appLog('Invalid bottom bar index: $index');
    }
  }
}
