import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/available_providers_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ProviderFiltersBottomSheet extends StatelessWidget {
  final AvailableProvidersController controller;

  const ProviderFiltersBottomSheet({
    super.key,
    required this.controller,
  });

  static Future<void> show(
    BuildContext context,
    AvailableProvidersController controller,
  ) {
    controller.initTempFilters();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProviderFiltersBottomSheet(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvailableProvidersController>(
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top drag handle
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

                14.height,

                /// Header Row: "Filters" and Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonText(
                      text: 'Filters',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
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

                20.height,

                /// Section 1: Distance Radius
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonText(
                      text: 'Distance Radius',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B68),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: CommonText(
                        text: '${controller.tempDistanceRadius.toInt()} km',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                10.height,

                /// Slider
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4.h,
                    activeTrackColor: const Color(0xFF1B2B68),
                    inactiveTrackColor: const Color(0xFFE2E8F0),
                    thumbColor: const Color(0xFF1B2B68),
                    overlayColor: const Color(0xFF1B2B68).withOpacity(0.12),
                    thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: 8.r),
                    overlayShape:
                        RoundSliderOverlayShape(overlayRadius: 16.r),
                  ),
                  child: Slider(
                    value: controller.tempDistanceRadius,
                    min: 1.0,
                    max: 30.0,
                    onChanged: (val) => controller.setTempDistance(val),
                  ),
                ),

                16.height,

                /// Section 2: Driver Gender
                const CommonText(
                  text: 'Driver Gender',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),

                12.height,

                /// Gender Selection Capsules
                Row(
                  children: controller.genderOptions.map((gender) {
                    final isSelected =
                        controller.tempSelectedGender == gender;

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: GestureDetector(
                          onTap: () => controller.setTempGender(gender),
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF1B2B68)
                                  : const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF1B2B68)
                                    : const Color(0xFFF1F5F9),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: CommonText(
                              text: gender,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                24.height,

                /// Apply Button
                GestureDetector(
                  onTap: () {
                    controller.applyFilters();
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2B68),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1B2B68).withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const CommonText(
                      text: 'Apply',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),

                12.height,
              ],
            ),
          ),
        );
      },
    );
  }
}
