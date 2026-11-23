import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentRideDetailsController extends GetxController {
  static StudentRideDetailsController get instance =>
      Get.find<StudentRideDetailsController>();

  String bookingId = 'SB-1092';
  String status = 'Confirmed';
  String serviceType = 'Carpool Ride';
  String date = 'Monday, Nov 24, 2026';
  String pickupTime = '08:15 AM';
  String pickupAddress = '18 Maple Avenue, Toronto, ON';
  String dropoffAddress = 'Seneca College - Newnham Campus, Gate 3';
  String driverName = 'David Miller';
  String driverRating = '4.95';
  String driverPhone = '+1 (416) 555-0182';
  String vehicle = 'Toyota Sienna (2023) • Silver';
  String plate = 'SCH-4091';
  String fare = '\$14.50';
  String studentName = 'Alex Morgan';
  String studentId = 'STU-992184';
  String campus = 'Seneca College';

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      if (Get.arguments['bookingId'] != null) {
        bookingId = Get.arguments['bookingId'];
      }
    }
  }

  void openLiveTracking() {
    Get.toNamed(AppRoutes.guardianLiveTrack);
  }

  void openChat() {
    Get.toNamed(AppRoutes.message);
  }

  void cancelRide() {
    AppSnackbar.success(
      title: 'Ride Cancelled',
      message: 'Your campus ride $bookingId has been cancelled.',
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.back();
    });
  }
}

