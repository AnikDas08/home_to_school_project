import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/controller/book_a_ride_controller.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_bottom_bar.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_children_card.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_datetime_card.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_notes_card.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_pickup_dropoff_card.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_repeat_card.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/widgets/book_ride_service_type_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BookARideScreen extends StatelessWidget {
  const BookARideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookARideController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

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
          text: 'Book a Ride',
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

      /// Body Content
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  children: [
                    /// 1. Children Selection Card
                    const BookRideChildrenCard(),

                    12.height,

                    /// 2. Pickup & Drop-off Location Card
                    const BookRidePickupDropoffCard(),

                    12.height,

                    /// 3. Date & Time Selection Card
                    const BookRideDateTimeCard(),

                    12.height,

                    /// 4. Repeat Card (Weekly/Monthly + Day Selector)
                    const BookRideRepeatCard(),

                    12.height,

                    /// 5. Service Type Card (Driver vs WalkShare Guide)
                    const BookRideServiceTypeCard(),

                    12.height,

                    /// 6. Additional Notes Card
                    const BookRideNotesCard(),

                    20.height,
                  ],
                ),
              ),
            ),

            /// Bottom Sticky Pricing & Action Bar
            const BookRideBottomBar(),
          ],
        ),
      ),
    );
  }
}
