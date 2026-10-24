import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/features/role/driver/availability/presentation/controller/driver_availability_controller.dart';

class DaySelectorWidget extends StatelessWidget {
  const DaySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverAvailabilityController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.weekDays.map((day) {
          final isSelected = controller.selectedDays.contains(day);

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.toggleDay(day),
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                height: 48.h,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1B2B68) : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1B2B68)
                        : const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1B2B68).withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
