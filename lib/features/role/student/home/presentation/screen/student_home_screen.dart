import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/features/role/student/home/presentation/controller/student_home_controller.dart';
import 'package:home_to_school/features/role/student/home/presentation/widgets/student_campus_banner.dart';
import 'package:home_to_school/features/role/student/home/presentation/widgets/student_header_widget.dart';
import 'package:home_to_school/features/role/student/home/presentation/widgets/student_quick_actions_widget.dart';
import 'package:home_to_school/features/role/student/home/presentation/widgets/student_todays_trips_widget.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentHomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<StudentHomeController>(
          builder: (ctrl) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. Header: Student Avatar with verified badge, greeting, notification
                  StudentHeaderWidget(
                    userName: ctrl.studentName,
                    subtitle: 'Campus Commute • ${ctrl.institutionName}',
                    notificationCount: 2,
                  ),

                  18.height,

                  /// 2. Student Campus Commute Pass Banner
                  const StudentCampusBanner(),

                  22.height,

                  /// 3. Quick Actions: Book a Ride, WalkShare, Student ID, Safety & Help
                  const StudentQuickActionsWidget(),

                  22.height,

                  /// 4. Today's Campus Rides Section
                  const StudentTodaysTripsWidget(),

                  24.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
