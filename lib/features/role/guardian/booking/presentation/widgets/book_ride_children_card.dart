import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_card_container.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/select_children_bottom_sheet.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookRideChildrenCard extends StatelessWidget {
  const BookRideChildrenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookARideController>(
      builder: (controller) {
        final hasSelection = controller.selectedChildrenIds.isNotEmpty;

        return GestureDetector(
          onTap: () => SelectChildrenBottomSheet.show(context, controller),
          behavior: HitTestBehavior.opaque,
          child: BookRideCardContainer(
            child: Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.people_alt_outlined,
                    size: 24.sp,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        text: 'Children',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                      2.height,
                      CommonText(
                        text: controller.selectedChildrenSubtitle,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: hasSelection
                            ? const Color(0xFF1B2B68)
                            : const Color(0xFF94A3B8),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
