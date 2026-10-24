import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/availability/presentation/controller/driver_availability_controller.dart';
import 'package:home_to_school/features/role/driver/availability/presentation/widgets/day_selector_widget.dart';
import 'package:home_to_school/features/role/driver/availability/presentation/widgets/escort_window_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverAvailabilityScreen extends StatelessWidget {
  const DriverAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverAvailabilityController());

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
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Availability',
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 1. Section Header: Active walking days
              const CommonText(
                text: 'Active walking days',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),

              14.height,

              /// 2. Day Selector Pills
              const DaySelectorWidget(),

              24.height,

              /// 3. Section Header: Escort time windows
              const CommonText(
                text: 'Escort time windows',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),

              14.height,

              /// 4. Card 1: Morning Escort
              Obx(
                () => EscortWindowCard(
                  iconWidget: const Icon(
                    Icons.wb_twilight_rounded,
                    color: Color(0xFFD97706),
                    size: 22,
                  ),
                  iconBgColor: const Color(0xFFFEF3C7),
                  title: 'Morning Escort',
                  subtitle: 'School drop-off window',
                  isEnabled: controller.isMorningEnabled.value,
                  onToggle: controller.toggleMorning,
                  startLabel: 'DEPARTURE FROM',
                  startTime: controller.morningDeparture.value,
                  onStartTap: () => controller.pickTime(
                    context: context,
                    targetTime: controller.morningDeparture,
                  ),
                  endLabel: 'ARRIVAL BY',
                  endTime: controller.morningArrival.value,
                  onEndTap: () => controller.pickTime(
                    context: context,
                    targetTime: controller.morningArrival,
                  ),
                ),
              ),

              14.height,

              /// 5. Card 2: Afternoon Escort
              Obx(
                () => EscortWindowCard(
                  iconWidget: const Icon(
                    Icons.wb_sunny_outlined,
                    color: Color(0xFF2563EB),
                    size: 22,
                  ),
                  iconBgColor: const Color(0xFFEFF6FF),
                  title: 'Afternoon Escort',
                  subtitle: 'School pickup & return window',
                  isEnabled: controller.isAfternoonEnabled.value,
                  onToggle: controller.toggleAfternoon,
                  startLabel: 'DISMISSAL FROM',
                  startTime: controller.afternoonDismissal.value,
                  onStartTap: () => controller.pickTime(
                    context: context,
                    targetTime: controller.afternoonDismissal,
                  ),
                  endLabel: 'HOME RETURN BY',
                  endTime: controller.afternoonReturn.value,
                  onEndTap: () => controller.pickTime(
                    context: context,
                    targetTime: controller.afternoonReturn,
                  ),
                ),
              ),

              20.height,

              /// 6. Active Schedule Summary Box
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FD),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: const Color(0xFFBFDBFE),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 22.w,
                        height: 22.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1B2B68),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      12.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CommonText(
                              text: 'ACTIVE SCHEDULE',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1B2B68),
                            ),
                            4.height,
                            CommonText(
                              text: controller.scheduleSummary,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1B2B68),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              24.height,

              /// 7. Save Changes Primary Button
              GestureDetector(
                onTap: controller.saveChanges,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2B68),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B2B68).withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: CommonText(
                      text: 'Save Changes',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
