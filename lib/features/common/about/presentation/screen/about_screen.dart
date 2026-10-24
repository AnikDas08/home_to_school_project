import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar: "About"
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
          text: 'About',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body Content matching Screenshot
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              10.height,

              /// Circular App Logo Badge
              Center(
                child: Container(
                  width: 74.w,
                  height: 74.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppImages.appIcon,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        radius: 37.r,
                        backgroundColor: const Color(0xFFEFF6FF),
                        child: const Icon(
                          Icons.directions_bus_rounded,
                          color: Color(0xFF1B2B68),
                          size: 34,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              14.height,

              /// Tagline under logo
              const Center(
                child: CommonText(
                  text: 'Safe, Verified School Commutes for Children',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                  textAlign: TextAlign.center,
                ),
              ),

              24.height,

              /// Card 1: About Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x04000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header: Icon + "About"
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 18.sp,
                          color: const Color(0xFF1B2B68),
                        ),
                        8.width,
                        const CommonText(
                          text: 'About',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B2B68),
                        ),
                      ],
                    ),

                    12.height,

                    /// Paragraph 1
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF475569),
                          height: 1.55,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Home2School ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          TextSpan(
                            text:
                                'is a specialized, safety-certified child transportation and school commute platform designed specifically for busy families. It gives parents a reliable, stress-free alternative to crowded buses and hectic morning drop-offs.',
                          ),
                        ],
                      ),
                    ),

                    12.height,

                    /// Paragraph 2
                    Text(
                      'Whether you need daily round-trip commutes, morning-only drop-offs, or a neighborhood walking school escort, Home2School matches your family with background-checked community drivers who treat your children like family.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF475569),
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),

              16.height,

              /// Card 2: Our Mission & Promise
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x04000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: 'Our Mission & Promise',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B2B68),
                    ),

                    12.height,

                    Text(
                      'Home2School was created by parents to eliminate daily school commute anxiety. We connect neighborhood families with certified, community-verified drivers and walking escorts to make morning drop-offs and afternoon pickups safe, peaceful, and predictable.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF475569),
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),

              30.height,
            ],
          ),
        ),
      ),
    );
  }
}
