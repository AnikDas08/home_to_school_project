import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentCampusBanner extends StatelessWidget {
  const StudentCampusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage(AppImages.homeScreenBackground),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          /// White gradient overlay specifically over the text section on the left
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 250.w,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white,
                    Colors.white.withValues(alpha: 0.96),
                    Colors.white.withValues(alpha: 0.88),
                    Colors.white.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.60, 0.82, 1.0],
                ),
              ),
            ),
          ),

          /// Typography content over the left section
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxTextWidth = constraints.maxWidth * 0.62;

                    return SizedBox(
                      width: maxTextWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_user_rounded,
                                  size: 11.sp,
                                  color: const Color(0xFF1E3A8A),
                                ),
                                4.width,
                                Text(
                                  'STUDENT COMMUTE PASS',
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E3A8A),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          6.height,
                          const CommonText(
                            text: 'Direct to Campus',
                            fontSize: 17.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            textAlign: TextAlign.start,
                          ),
                          2.height,
                          const CommonText(
                            text: 'Safe & On-Time',
                            fontSize: 17.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF10B981),
                            textAlign: TextAlign.start,
                          ),
                          6.height,
                          Text(
                            'Personal rides & verified walk shares for your college commute.',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF64748B),
                              height: 1.25,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

