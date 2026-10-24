import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/guardian_live_track_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianLiveTrackScreen extends StatelessWidget {
  const GuardianLiveTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuardianLiveTrackController());
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Stack(
        children: [
          /// 1. Map Layer with interactive zoom & route overlay
          Positioned.fill(
            child: Obx(
              () => Transform.scale(
                scale: controller.zoomLevel.value,
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    /// Background Map image
                    Image.asset(
                      AppImages.mapImageShow,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFE2E8F0),
                        child: const Center(
                          child: Icon(
                            Icons.map_rounded,
                            size: 64,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ),

                    /// Custom route line painter
                    CustomPaint(
                      size: Size.infinite,
                      painter: _GuardianRoutePainter(),
                    ),

                    /// Destination Marker & Callout (Top-Left: Greenfield International School)
                    Positioned(
                      top: 155.h,
                      left: 80.w,
                      child: _buildDestinationCallout(),
                    ),

                    /// Origin Marker & Callout (Bottom-Right: 12 Elm Street, Toronto, ON)
                    Positioned(
                      bottom: 275.h,
                      right: 18.w,
                      child: _buildOriginCallout(),
                    ),

                    /// Live Vehicle Marker with Blue Glow Halo (Center on route)
                    Positioned(
                      top: 390.h,
                      left: 175.w,
                      child: _buildLiveVehicleMarker(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 2. Right Side Map Controls (Compass & Zoom)
          Positioned(
            top: 215.h,
            right: 16.w,
            child: Column(
              children: [
                /// Compass / Recenter Button
                GestureDetector(
                  onTap: controller.onRecenterMap,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.explore_outlined,
                        color: Color(0xFF0284C7),
                        size: 22,
                      ),
                    ),
                  ),
                ),

                12.height,

                /// Zoom Controls (+ / -)
                Container(
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: controller.onZoomIn,
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 40.w,
                          height: 38.h,
                          child: const Icon(
                            Icons.add_rounded,
                            color: Color(0xFF475569),
                            size: 20,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF1F5F9),
                      ),
                      GestureDetector(
                        onTap: controller.onZoomOut,
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 40.w,
                          height: 38.h,
                          child: const Icon(
                            Icons.remove_rounded,
                            color: Color(0xFF475569),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 3. Top Floating App Bar (Liam & Emma + SOS)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Back Button
                      GestureDetector(
                        onTap: () => Get.back(),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8FAFC),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 24,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),

                      /// Trip Title
                      const CommonText(
                        text: 'Liam & Emma',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),

                      /// Red SOS Button
                      GestureDetector(
                        onTap: controller.onSosTap,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFEE2E2),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.shield_outlined,
                              size: 19,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 4. Bottom Info Sheet (Floating bottom card matching Image)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                20.w,
                10.h,
                20.w,
                bottomPadding > 0 ? bottomPadding + 10.h : 22.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Drag Handle
                  Center(
                    child: Container(
                      width: 38.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),

                  12.height,

                  /// Row 1: Live Status Badge + ETA Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Live Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFA7F3D0),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7.w,
                              height: 7.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            5.width,
                            const Text(
                              'Live',
                              style: TextStyle(
                                color: Color(0xFF047857),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ETA Time & Label
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const CommonText(
                            text: '07:42 AM',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                          2.height,
                          const CommonText(
                            text: 'ETA',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8),
                          ),
                        ],
                      ),
                    ],
                  ),

                  4.height,

                  /// Row 2: Destination Header
                  const CommonText(
                    text: 'Greenfield International School',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),

                  14.height,

                  /// Row 3: Driver Avatar + Name + Vehicle Info + Chat Button
                  Row(
                    children: [
                      /// Driver Avatar
                      ClipOval(
                        child: Image.asset(
                          AppImages.profileImage,
                          width: 44.w,
                          height: 44.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => CircleAvatar(
                            radius: 22.r,
                            backgroundColor: const Color(0xFFEFF6FF),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                      ),

                      12.width,

                      /// Driver Name & Vehicle Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CommonText(
                                  text: 'Tariq Ahmed',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                                3.width,
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 18,
                                  color: Color(0xFF64748B),
                                ),
                              ],
                            ),
                            2.height,
                            const CommonText(
                              text: 'Toyota Sienna (2023) • SCH-4091',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ),

                      /// Message/Chat Button
                      GestureDetector(
                        onTap: controller.onMessageDriver,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 42.w,
                          height: 42.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 19,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  16.height,

                  /// Row 4: Trip Details link (left) & Report Issue link (right)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Trip Details
                      GestureDetector(
                        onTap: controller.onTripDetails,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Icon(
                              Icons.assignment_outlined,
                              size: 16.sp,
                              color: const Color(0xFF2563EB),
                            ),
                            6.width,
                            const CommonText(
                              text: 'Trip Details',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2563EB),
                            ),
                          ],
                        ),
                      ),

                      /// Report Issue
                      GestureDetector(
                        onTap: () => controller.onReportIssue(context),
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 16.sp,
                              color: const Color(0xFFEF4444),
                            ),
                            6.width,
                            const CommonText(
                              text: 'Report Issue',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFEF4444),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Destination Callout (Greenfield International School)
  Widget _buildDestinationCallout() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Red Pin Icon
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEF4444).withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),

        8.width,

        /// Floating Pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: 'Greenfield',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  CommonText(
                    text: 'International School',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ],
              ),
              6.width,
              const Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Origin Callout (12 Elm Street, Toronto, ON)
  Widget _buildOriginCallout() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Green Pin Icon
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),

        8.width,

        /// Floating Pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: '12 Elm Street',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  CommonText(
                    text: 'Toronto, ON',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
              6.width,
              const Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Live Vehicle Marker with Blue Halo on the Route
  Widget _buildLiveVehicleMarker() {
    return SizedBox(
      width: 54.w,
      height: 54.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Glowing blue pulse halo
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF3B82F6).withOpacity(0.22),
            ),
          ),

          /// Vehicle Body (facing upward diagonally along road)
          Transform.rotate(
            angle: -math.pi / 20, // subtle alignment with the road
            child: Container(
              width: 26.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF0F172A),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Front windshield
                  Container(
                    width: 18.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  /// Roof
                  Container(
                    width: 18.w,
                    height: 10.h,
                    color: Colors.white,
                  ),

                  /// Rear windshield
                  Container(
                    width: 18.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Route Polyline Painter
class _GuardianRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Coordinates mapped proportionally to match user screenshot route:
    // Origin at bottom-right near 12 Elm Street
    final startX = size.width * 0.73;
    final startY = size.height * 0.635;

    // Corner turning west onto Elm St
    final corner1X = size.width * 0.64;
    final corner1Y = size.height * 0.645;

    // Long straight diagonal heading north-northwest
    final corner2X = size.width * 0.44;
    final corner2Y = size.height * 0.285;

    // Turning left into school approach
    final corner3X = size.width * 0.32;
    final corner3Y = size.height * 0.29;

    // Destination at Greenfield International School
    final destX = size.width * 0.265;
    final destY = size.height * 0.20;

    path.moveTo(startX, startY);
    path.lineTo(corner1X, corner1Y);
    path.lineTo(corner2X, corner2Y);
    path.lineTo(corner3X, corner3Y);
    path.lineTo(destX, destY);

    // Draw route line
    canvas.drawPath(path, paint);

    // Start point dot
    final dotPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(startX, startY), 4.5, dotPaint);

    // End point dot
    final endDotPaint = Paint()
      ..color = const Color(0xFFEF4444)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(destX, destY), 4.5, endDotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
