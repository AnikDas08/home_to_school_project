import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_card_container.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookRideNotesCard extends StatelessWidget {
  const BookRideNotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookARideController>(
      builder: (controller) {
        return BookRideCardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 19.sp,
                    color: const Color(0xFF0F172A),
                  ),
                  8.width,
                  const CommonText(
                    text: 'Additional Notes',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ],
              ),

              12.height,

              Container(
                height: 76.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: controller.notesController,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText:
                        'e.g. Gate 2 pickup, booster seat required, handover PIN instructions...',
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
