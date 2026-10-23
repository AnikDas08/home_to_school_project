import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/controller/guardian_profile_controller.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class SwitchRoleDialog extends StatefulWidget {
  const SwitchRoleDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const SwitchRoleDialog(),
    );
  }

  @override
  State<SwitchRoleDialog> createState() => _SwitchRoleDialogState();
}

class _SwitchRoleDialogState extends State<SwitchRoleDialog> {
  String _activeRole = 'Parent';

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<GuardianProfileController>()) {
      _activeRole = Get.find<GuardianProfileController>().activeRole;
    }
  }

  void _onSelectRole(String role) {
    setState(() {
      _activeRole = role;
    });

    if (Get.isRegistered<GuardianProfileController>()) {
      final profileCtrl = Get.find<GuardianProfileController>();
      profileCtrl.activeRole = role;
      profileCtrl.update();
    }

    Navigator.pop(context);

    AppSnackbar.success(
      title: 'Role Switched',
      message: 'Active role updated to $role',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Top Small Pill Handle
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            12.height,

            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: 'Switch role',
                  fontSize: 17.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close_rounded,
                      size: 16.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),

            18.height,

            /// 1. Parent
            _buildRoleCard(
              title: 'Parent',
              iconWidget: Icon(
                Icons.person_outline_rounded,
                size: 20.sp,
                color: Colors.white,
              ),
              iconBgColor: const Color(0xFF1B2B68),
              isActive: _activeRole == 'Parent',
              onTap: () => _onSelectRole('Parent'),
            ),

            12.height,

            /// 2. Driver / Carpool
            _buildRoleCard(
              title: 'Driver / Carpool',
              iconWidget: Icon(
                Icons.directions_car_rounded,
                size: 20.sp,
                color: Colors.white,
              ),
              iconBgColor: const Color(0xFFEA580C),
              isActive: _activeRole == 'Driver / Carpool' ||
                  _activeRole == 'Driver',
              onTap: () => _onSelectRole('Driver / Carpool'),
            ),

            12.height,

            /// 3. WalkShare
            _buildRoleCard(
              title: 'WalkShare',
              iconWidget: const _FootprintsIcon(),
              iconBgColor: const Color(0xFF059669),
              isActive: _activeRole == 'WalkShare',
              onTap: () => _onSelectRole('WalkShare'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required Widget iconWidget,
    required Color iconBgColor,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF1F4FD) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isActive ? const Color(0xFF1B2B68) : const Color(0xFFE2E8F0),
            width: isActive ? 1.4 : 1.0,
          ),
        ),
        child: Row(
          children: [
            /// Leading Icon Box
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: iconWidget,
            ),

            14.width,

            /// Title
            Expanded(
              child: CommonText(
                text: title,
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                textAlign: TextAlign.start,
              ),
            ),

            /// Trailing Badge or Button
            if (isActive)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: const CommonText(
                  text: 'Active',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 0.8,
                  ),
                ),
                child: const CommonText(
                  text: 'Switch',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the two footprints icon
class _FootprintsIcon extends StatelessWidget {
  const _FootprintsIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.sp,
      height: 20.sp,
      child: CustomPaint(
        painter: _FootprintsPainter(),
      ),
    );
  }
}

class _FootprintsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Left footprint sole
    final leftRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.12,
        size.height * 0.22,
        size.width * 0.32,
        size.height * 0.65,
      ),
      const Radius.circular(5),
    );
    canvas.drawRRect(leftRect, paint);
    canvas.drawCircle(
      Offset(size.width * 0.28, size.height * 0.45),
      1.2,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.28, size.height * 0.65),
      1.2,
      dotPaint,
    );

    // Right footprint sole (slightly staggered)
    final rightRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.56,
        size.height * 0.12,
        size.width * 0.32,
        size.height * 0.65,
      ),
      const Radius.circular(5),
    );
    canvas.drawRRect(rightRect, paint);
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.35),
      1.2,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.55),
      1.2,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
