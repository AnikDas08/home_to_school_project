import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_to_school/utils/helpers/other_helper.dart';

class DriverAvailabilityController extends GetxController {
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// Selected days list (Default: Mon, Tue, Wed, Thu, Fri)
  final RxList<String> selectedDays =
      <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri'].obs;

  /// Morning Escort
  final isMorningEnabled = true.obs;
  final morningDeparture = '07:15 AM'.obs;
  final morningArrival = '08:45 AM'.obs;

  /// Afternoon Escort
  final isAfternoonEnabled = true.obs;
  final afternoonDismissal = '02:30 PM'.obs;
  final afternoonReturn = '04:00 PM'.obs;

  /// Toggle day selection
  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      if (selectedDays.length > 1) {
        selectedDays.remove(day);
      } else {
        Get.snackbar(
          'Notice',
          'At least one active day must be selected.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1E293B),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      }
    } else {
      selectedDays.add(day);
    }
  }

  /// Toggle morning window
  void toggleMorning(bool val) {
    isMorningEnabled.value = val;
  }

  /// Toggle afternoon window
  void toggleAfternoon(bool val) {
    isAfternoonEnabled.value = val;
  }

  /// Time picker
  Future<void> pickTime({
    required BuildContext context,
    required RxString targetTime,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _parseTime(targetTime.value),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B2B68),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      final formattedHour = hour.toString().padLeft(2, '0');
      targetTime.value = '$formattedHour:$minute $period';
    }
  }

  TimeOfDay _parseTime(String timeString) {
    try {
      final parts = timeString.split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final isPm = parts[1].toUpperCase() == 'PM';

      if (isPm && hour != 12) hour += 12;
      if (!isPm && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return TimeOfDay.now();
    }
  }

  /// Dynamic formatted schedule summary
  String get scheduleSummary {
    String daysPart = '';
    final isMonToFri = selectedDays.length == 5 &&
        selectedDays.contains('Mon') &&
        selectedDays.contains('Tue') &&
        selectedDays.contains('Wed') &&
        selectedDays.contains('Thu') &&
        selectedDays.contains('Fri');

    if (isMonToFri) {
      daysPart = 'Mon-Fri';
    } else if (selectedDays.length == 7) {
      daysPart = 'Everyday';
    } else {
      daysPart = selectedDays.join(', ');
    }

    final List<String> timeWindows = [];
    if (isMorningEnabled.value) {
      timeWindows.add('${morningDeparture.value} - ${morningArrival.value}');
    }
    if (isAfternoonEnabled.value) {
      timeWindows.add('${afternoonDismissal.value} - ${afternoonReturn.value}');
    }

    if (timeWindows.isEmpty) {
      return '$daysPart · No active time windows';
    }

    return '$daysPart · ${timeWindows.join(' & ')}';
  }

  /// Save changes action
  void saveChanges() {
    Get.back();
    Get.snackbar(
      'Availability Updated',
      'Your active schedule and driving windows have been saved.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF1B2B68),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Color(0xFF22C55E),
      ),
    );
  }
}
