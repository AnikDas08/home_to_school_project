import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class EscortWindowCard extends StatelessWidget {
  final Widget iconWidget;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final bool isEnabled;
  final ValueChanged<bool> onToggle;
  final String startLabel;
  final String startTime;
  final VoidCallback onStartTap;
  final String endLabel;
  final String endTime;
  final VoidCallback onEndTap;

  const EscortWindowCard({
    super.key,
    required this.iconWidget,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.isEnabled,
    required this.onToggle,
    required this.startLabel,
    required this.startTime,
    required this.onStartTap,
    required this.endLabel,
    required this.endTime,
    required this.onEndTap,
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row (Icon, Title/Subtitle, CupertinoSwitch)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Leading Icon Container
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: iconWidget,
              ),

              12.width,

              /// Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    3.height,
                    CommonText(
                      text: subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),

              /// Navy Blue Toggle Switch
              CupertinoSwitch(
                value: isEnabled,
                activeColor: const Color(0xFF1B2B68),
                onChanged: onToggle,
              ),
            ],
          ),

          16.height,

          /// Time Windows Row (Departure / Arrival fields)
          Opacity(
            opacity: isEnabled ? 1.0 : 0.45,
            child: Row(
              children: [
                /// Start Field
                Expanded(
                  child: _buildTimeInputBox(
                    label: startLabel,
                    time: startTime,
                    onTap: isEnabled ? onStartTap : () {},
                  ),
                ),

                12.width,

                /// End Field
                Expanded(
                  child: _buildTimeInputBox(
                    label: endLabel,
                    time: endTime,
                    onTap: isEnabled ? onEndTap : () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInputBox({
    required String label,
    required String time,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF64748B),
        ),
        6.height,
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: time,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                Icon(
                  Icons.access_time_rounded,
                  size: 18.sp,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
