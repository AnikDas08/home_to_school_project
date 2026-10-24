import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverRequestEarningsCard extends StatelessWidget {
  final String amount;
  final String period;

  const DriverRequestEarningsCard({
    super.key,
    required this.amount,
    required this.period,
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
                Icons.credit_card_outlined,
                size: 16.sp,
                color: const Color(0xFF64748B),
              ),
              8.width,
              const CommonText(
                text: 'TRIP EARNINGS & PAYMENT',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                textAlign: TextAlign.start,
              ),
            ],
          ),

          12.height,

          /// Price Display
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CommonText(
                text: amount,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1B2B68),
              ),
              6.width,
              CommonText(
                text: period,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
