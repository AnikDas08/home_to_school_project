import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/available_providers_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ProviderQuickFilterChips extends StatelessWidget {
  const ProviderQuickFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvailableProvidersController>(
      builder: (controller) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            children: controller.quickFilters.map((filter) {
              final isSelected = controller.selectedQuickFilter == filter;

              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () => controller.selectQuickFilter(filter),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1B2B68)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: CommonText(
                      text: filter,
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF475569),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
