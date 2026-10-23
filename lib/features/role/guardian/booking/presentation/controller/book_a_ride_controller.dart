import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/utils/app_snackbar.dart';

class ChildModel {
  final String id;
  final String name;
  final String school;
  final String? image;

  const ChildModel({
    required this.id,
    required this.name,
    required this.school,
    this.image,
  });
}

class BookARideController extends GetxController {
  static BookARideController get instance => Get.find<BookARideController>();

  /// All available children
  final List<ChildModel> allChildren = const [
    ChildModel(
      id: '1',
      name: 'Arman Khan',
      school: 'Grade 4 • Greenfield International School',
    ),
    ChildModel(
      id: '2',
      name: 'Emma Khan',
      school: 'Grade 2 • Greenfield International School',
    ),
    ChildModel(
      id: '3',
      name: 'Zara Khan',
      school: 'Pre-K • Sunshine Pre-school',
    ),
  ];

  /// Selected Children IDs
  final Set<String> selectedChildrenIds = {};

  /// Locations
  String? pickupLocation;
  String? dropOffLocation;

  /// Trip Type: One way vs Round trip (Round trip active by default as in images)
  bool isRoundTrip = true;

  /// Date & Time
  DateTime selectedDate = DateTime(2026, 9, 8);
  DateTime displayedCalendarMonth = DateTime(2026, 9, 1);
  String? pickupTime = '07:30 AM';
  String? dropOffTime = '03:30 PM';

  /// Repeat settings
  String repeatType = 'Monthly'; // 'Weekly' or 'Monthly'
  bool repeatEnabled = true;
  final Set<String> selectedDays = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri'};
  bool untilCancelled = true;
  DateTime? endDate;

  /// Service type: 'Driver' or 'WalkShare Guide'
  String serviceType = 'Driver';

  /// Additional Notes
  final TextEditingController notesController = TextEditingController();

  final List<String> weekDays = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  // ==========================================
  // GETTERS & COMPUTED PROPERTIES
  // ==========================================
  String get selectedChildrenSubtitle {
    final names = allChildren
        .where((c) => selectedChildrenIds.contains(c.id))
        .map((c) => c.name)
        .toList();
    return names.isEmpty ? 'Select children' : names.join(', ');
  }

  String get formattedSelectedDate {
    return DateFormat('EEE, MMM d, yyyy').format(selectedDate);
  }

  String get estimatedPrice => '\$61.48';
  String get estimatedDistance => '5.4 km';

  // ==========================================
  // CONTROLLER ACTIONS
  // ==========================================
  void setChildren(Set<String> ids) {
    selectedChildrenIds.clear();
    selectedChildrenIds.addAll(ids);
    update();
  }

  void toggleChild(String id) {
    if (selectedChildrenIds.contains(id)) {
      selectedChildrenIds.remove(id);
    } else {
      selectedChildrenIds.add(id);
    }
    update();
  }

  void setRoundTrip(bool value) {
    isRoundTrip = value;
    update();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void setCalendarMonth(DateTime month) {
    displayedCalendarMonth = month;
    update();
  }

  void setPickupTime(String time) {
    pickupTime = time;
    update();
  }

  void setDropOffTime(String time) {
    dropOffTime = time;
    update();
  }

  void setRepeatType(String type) {
    repeatType = type;
    repeatEnabled = true;
    update();
  }

  void setRepeatEnabled(bool value) {
    repeatEnabled = value;
    update();
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    update();
  }

  void setUntilCancelled(bool value) {
    untilCancelled = value;
    update();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    update();
  }

  void setServiceType(String type) {
    serviceType = type;
    update();
  }

  void setPickupLocation(String loc) {
    pickupLocation = loc;
    update();
  }

  void setDropOffLocation(String loc) {
    dropOffLocation = loc;
    update();
  }

  void searchProviders() {
    if (selectedChildrenIds.isEmpty) {
      AppSnackbar.error(
        message: 'Please select at least one child',
      );
      return;
    }
    AppSnackbar.success(
      title: 'Booking',
      message: 'Searching available providers for your commute...',
    );
  }
}
