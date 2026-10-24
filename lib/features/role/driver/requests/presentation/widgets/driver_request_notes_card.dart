import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestNotesCard extends StatelessWidget {
  final String notes;

  const DriverRequestNotesCard({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Header
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 16.sp,
                color: const Color(0xFF64748B),
              ),
              8.width,
              const CommonText(
                text: 'SPECIAL NOTES',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                textAlign: TextAlign.start,
              ),
            ],
          ),

          12.height,

          /// Note content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Icon(
                  Icons.people_alt_outlined,
                  size: 18.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
              10.width,
              Expanded(
                child: CommonText(
                  text: notes,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF334155),
                  textAlign: TextAlign.start,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
