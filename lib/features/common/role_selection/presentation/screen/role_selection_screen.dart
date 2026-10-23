import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/constants/app_string.dart';
import 'package:home_to_school/utils/extensions/extension.dart';
import '../controller/role_selection_controller.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleSelectionController>(
      init: RoleSelectionController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.titleColor,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          20.height,

                          /// Screen Title
                          const CommonText(
                            text: AppString.chooseYourRole,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.titleColor,
                            textAlign: TextAlign.center,
                          ),

                          8.height,

                          /// Screen Subtitle
                          const CommonText(
                            text: AppString.chooseYourRoleSubtitle,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subtitleColor,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),

                          32.height,

                          /// Role Selection Cards
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.roles.length,
                            separatorBuilder: (_, __) => 14.height,
                            itemBuilder: (context, index) {
                              final role = controller.roles[index];
                              final isSelected = controller.selectedIndex == index;

                              return GestureDetector(
                                onTap: () => controller.selectRole(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.borderColor,
                                      width: isSelected ? 1.8 : 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      /// Left Icon Container
                                      Container(
                                        width: 48.w,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.iconBgColor,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: _buildRoleIcon(
                                          role.iconType,
                                          AppColors.primaryColor,
                                        ),
                                      ),

                                      14.width,

                                      /// Title and Subtitle Column
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CommonText(
                                              text: role.title,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.titleColor,
                                              textAlign: TextAlign.start,
                                            ),
                                            4.height,
                                            CommonText(
                                              text: role.subtitle,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.subtitleColor,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          28.height,

                          /// Continue Button
                          CommonButton(
                            titleText: AppString.continues,
                            onTap: controller.continueToSignUp,
                          ),

                          20.height,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleIcon(RoleIconType type, Color color) {
    switch (type) {
      case RoleIconType.parent:
        return Icon(
          Icons.people_outline_rounded,
          color: color,
          size: 24.sp,
        );
      case RoleIconType.driver:
        return Icon(
          Icons.directions_car_outlined,
          color: color,
          size: 24.sp,
        );
      case RoleIconType.walkShare:
        return CustomPaint(
          size: Size(22.sp, 22.sp),
          painter: _FootprintsPainter(color: color),
        );
    }
  }
}

/// Custom painter for the WalkShare two shoe soles / footsteps icon
class _FootprintsPainter extends CustomPainter {
  final Color color;

  _FootprintsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Left footprint (front toe + heel)
    final leftToe = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.12, h * 0.12, w * 0.32, h * 0.46),
      Radius.circular(w * 0.16),
    );
    final leftHeel = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.15, h * 0.66, w * 0.26, h * 0.22),
      Radius.circular(w * 0.10),
    );
    canvas.drawRRect(leftToe, paint);
    canvas.drawRRect(leftHeel, paint);

    // Right footprint (front toe + heel)
    final rightToe = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.56, h * 0.12, w * 0.32, h * 0.46),
      Radius.circular(w * 0.16),
    );
    final rightHeel = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.59, h * 0.66, w * 0.26, h * 0.22),
      Radius.circular(w * 0.10),
    );
    canvas.drawRRect(rightToe, paint);
    canvas.drawRRect(rightHeel, paint);
  }

  @override
  bool shouldRepaint(covariant _FootprintsPainter oldDelegate) =>
      oldDelegate.color != color;
}
