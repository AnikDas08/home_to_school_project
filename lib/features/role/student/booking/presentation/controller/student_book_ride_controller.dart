import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentBookRideController extends GetxController {
  static StudentBookRideController get instance =>
      Get.find<StudentBookRideController>();

  final TextEditingController pickupController =
      TextEditingController(text: '18 Maple Avenue, Toronto, ON');
  final TextEditingController dropoffController =
      TextEditingController(text: 'Seneca College - Newnham Campus, Gate 3');
  final TextEditingController notesController = TextEditingController();

  String selectedService = 'Carpool Ride'; // 'Carpool Ride' or 'WalkShare Commute'
  bool isRoundTrip = false;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay pickupTime = const TimeOfDay(hour: 8, minute: 15);
  TimeOfDay returnTime = const TimeOfDay(hour: 16, minute: 30);

  String studentName = 'Alex Morgan';
  String studentId = 'STU-992184';
  String institution = 'Seneca College';

  double get estimatedFare {
    if (selectedService.toLowerCase().contains('walk')) {
      return isRoundTrip ? 15.00 : 8.00;
    }
    return isRoundTrip ? 26.50 : 14.50;
  }

  @override
  void onInit() {
    super.onInit();
    if (LocalStorage.myName.isNotEmpty) {
      studentName = LocalStorage.myName;
    }
    if (LocalStorage.myAddress.isNotEmpty) {
      pickupController.text = LocalStorage.myAddress;
    }
    if (Get.arguments != null && Get.arguments is Map) {
      if (Get.arguments['isWalkShare'] == true) {
        selectedService = 'WalkShare Commute';
      }
    }
  }

  void setService(String service) {
    selectedService = service;
    update();
  }

  void toggleRoundTrip(bool value) {
    isRoundTrip = value;
    update();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void setPickupTime(TimeOfDay time) {
    pickupTime = time;
    update();
  }

  void setReturnTime(TimeOfDay time) {
    returnTime = time;
    update();
  }

  String get formattedDate => DateFormat('EEE, MMM dd, yyyy').format(selectedDate);

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  void swapLocations() {
    final temp = pickupController.text;
    pickupController.text = dropoffController.text;
    dropoffController.text = temp;
    update();
  }

  void confirmBooking() {
    if (pickupController.text.trim().isEmpty) {
      AppSnackbar.error(
        title: 'Pickup Location Required',
        message: 'Please enter your pickup location.',
      );
      return;
    }
    if (dropoffController.text.trim().isEmpty) {
      AppSnackbar.error(
        title: 'Drop-off Location Required',
        message: 'Please enter your drop-off campus address.',
      );
      return;
    }

    Get.toNamed(AppRoutes.availableProviders);
  }

  @override
  void onClose() {
    pickupController.dispose();
    dropoffController.dispose();
    notesController.dispose();
    super.onClose();
  }
}

