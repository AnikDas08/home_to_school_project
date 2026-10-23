import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class GuardianSafeRideBanner extends StatelessWidget {
  const GuardianSafeRideBanner({super.key});

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
            color: Colors.black.withOpacity(0.04),
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
            width: 200.w,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.96),
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.50, 0.75, 1.0],
                ),
              ),
            ),
          ),

          /// Typography content over the left section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonText(
                  text: 'Safe Ride',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  textAlign: TextAlign.start,
                ),
                2.height,
                const CommonText(
                  text: 'Brighter Future',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFEA580C),
                  textAlign: TextAlign.start,
                ),
                8.height,
                SizedBox(
                  width: 145.w,
                  child: const CommonText(
                    text: "Trusted school transport for your child's everyday journey",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
