import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/available_providers_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/provider_filters_bottom_sheet.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/provider_list_item.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/provider_quick_filter_chips.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class AvailableProvidersScreen extends StatelessWidget {
  const AvailableProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvailableProvidersController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
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
          text: 'Available Providers',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        actions: [
          /// Map view button (as shown in Image 2)
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.map_outlined,
                size: 18.sp,
                color: const Color(0xFF0F172A),
              ),
              onPressed: () {},
            ),
          ),

          8.width,

          /// Filter button
          Container(
            margin: EdgeInsets.only(right: 16.w),
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.tune_rounded,
                size: 18.sp,
                color: const Color(0xFF0F172A),
              ),
              onPressed: () =>
                  ProviderFiltersBottomSheet.show(context, controller),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body with Quick Filters and Provider List
      body: SafeArea(
        child: Column(
          children: [
            /// Quick Filter Tabs: All, Nearest, Rating
            const ProviderQuickFilterChips(),

            4.height,

            /// Filtered Providers List
            Expanded(
              child: GetBuilder<AvailableProvidersController>(
                builder: (_) {
                  final list = controller.filteredProviders;

                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search_outlined,
                            size: 56.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          14.height,
                          const CommonText(
                            text: 'No providers match your filter',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                          8.height,
                          GestureDetector(
                            onTap: () {
                              controller.setTempDistance(30.0);
                              controller.setTempGender('All');
                              controller.applyFilters();
                            },
                            child: const CommonText(
                              text: 'Reset Filters',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1B2B68),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final provider = list[index];
                      return ProviderListItem(
                        provider: provider,
                        onTap: () => Get.toNamed(
                          AppRoutes.driverProfile,
                          arguments: provider,
                        ),
                        onRequestBooking: () => Get.toNamed(
                          AppRoutes.bookingSummary,
                          arguments: provider,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
