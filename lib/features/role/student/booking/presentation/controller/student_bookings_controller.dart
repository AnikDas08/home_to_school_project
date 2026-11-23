import 'package:get/get.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentBookingItem {
  final String id;
  final String month;
  final String day;
  final String weekday;
  final String time;
  final String pickupAddress;
  final String dropoffAddress;
  final String serviceType;
  final String providerName;
  final String providerRating;
  final String vehicleInfo;
  final String fare;
  final String status;
  final bool isRoundTrip;

  const StudentBookingItem({
    required this.id,
    required this.month,
    required this.day,
    required this.weekday,
    required this.time,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.serviceType,
    required this.providerName,
    required this.providerRating,
    required this.vehicleInfo,
    required this.fare,
    required this.status,
    this.isRoundTrip = false,
  });
}

class StudentBookingsController extends GetxController {
  static StudentBookingsController get instance =>
      Get.find<StudentBookingsController>();

  int selectedTabIndex = 0;

  final List<StudentBookingItem> upcomingBookings = [
    const StudentBookingItem(
      id: 'SB-1092',
      month: 'NOV',
      day: '24',
      weekday: 'Mon',
      time: '08:15 AM',
      pickupAddress: '18 Maple Avenue, Toronto',
      dropoffAddress: 'Seneca College - Newnham Gate 3',
      serviceType: 'Carpool Ride',
      providerName: 'David Miller',
      providerRating: '4.95',
      vehicleInfo: 'Toyota Sienna • SCH-4091',
      fare: '\$14.50',
      status: 'Confirmed',
    ),
    const StudentBookingItem(
      id: 'SB-1093',
      month: 'NOV',
      day: '24',
      weekday: 'Mon',
      time: '04:30 PM',
      pickupAddress: 'Seneca College - Student Union',
      dropoffAddress: '18 Maple Avenue, Toronto',
      serviceType: 'WalkShare Commute',
      providerName: 'Sarah Jenkins',
      providerRating: '4.88',
      vehicleInfo: 'Campus WalkShare Group (4 students)',
      fare: '\$8.00',
      status: 'Confirmed',
    ),
    const StudentBookingItem(
      id: 'SB-1094',
      month: 'NOV',
      day: '25',
      weekday: 'Tue',
      time: '09:00 AM & 05:00 PM',
      pickupAddress: '18 Maple Avenue, Toronto',
      dropoffAddress: 'Seneca College - Engineering Building',
      serviceType: 'Carpool Ride',
      providerName: 'Robert Vance',
      providerRating: '4.91',
      vehicleInfo: 'Honda Odyssey • ON-8821',
      fare: '\$26.00',
      status: 'Scheduled',
      isRoundTrip: true,
    ),
  ];

  final List<StudentBookingItem> historyBookings = [
    const StudentBookingItem(
      id: 'SB-1081',
      month: 'NOV',
      day: '21',
      weekday: 'Fri',
      time: '08:15 AM',
      pickupAddress: '18 Maple Avenue, Toronto',
      dropoffAddress: 'Seneca College - Newnham Gate 3',
      serviceType: 'Carpool Ride',
      providerName: 'David Miller',
      providerRating: '4.95',
      vehicleInfo: 'Toyota Sienna • SCH-4091',
      fare: '\$14.50',
      status: 'Completed',
    ),
    const StudentBookingItem(
      id: 'SB-1080',
      month: 'NOV',
      day: '20',
      weekday: 'Thu',
      time: '04:30 PM',
      pickupAddress: 'Seneca College - Student Union',
      dropoffAddress: '18 Maple Avenue, Toronto',
      serviceType: 'WalkShare Commute',
      providerName: 'Sarah Jenkins',
      providerRating: '4.88',
      vehicleInfo: 'Campus WalkShare Group',
      fare: '\$8.00',
      status: 'Completed',
    ),
    const StudentBookingItem(
      id: 'SB-1077',
      month: 'NOV',
      day: '19',
      weekday: 'Wed',
      time: '08:00 AM',
      pickupAddress: '18 Maple Avenue, Toronto',
      dropoffAddress: 'York University - Student Centre',
      serviceType: 'Carpool Ride',
      providerName: 'Michael Chang',
      providerRating: '4.97',
      vehicleInfo: 'Chrysler Pacifica • CAN-1029',
      fare: '\$18.00',
      status: 'Completed',
    ),
  ];

  final List<StudentBookingItem> cancelledBookings = [
    const StudentBookingItem(
      id: 'SB-1065',
      month: 'NOV',
      day: '14',
      weekday: 'Fri',
      time: '08:15 AM',
      pickupAddress: '18 Maple Avenue, Toronto',
      dropoffAddress: 'Seneca College - Newnham Gate 3',
      serviceType: 'Carpool Ride',
      providerName: 'David Miller',
      providerRating: '4.95',
      vehicleInfo: 'Toyota Sienna • SCH-4091',
      fare: '\$14.50',
      status: 'Cancelled by Student',
    ),
  ];

  void selectTab(int index) {
    selectedTabIndex = index;
    update();
  }

  void cancelBooking(String id) {
    final index = upcomingBookings.indexWhere((e) => e.id == id);
    if (index != -1) {
      final removed = upcomingBookings.removeAt(index);
      cancelledBookings.insert(
        0,
        StudentBookingItem(
          id: removed.id,
          month: removed.month,
          day: removed.day,
          weekday: removed.weekday,
          time: removed.time,
          pickupAddress: removed.pickupAddress,
          dropoffAddress: removed.dropoffAddress,
          serviceType: removed.serviceType,
          providerName: removed.providerName,
          providerRating: removed.providerRating,
          vehicleInfo: removed.vehicleInfo,
          fare: removed.fare,
          status: 'Cancelled',
          isRoundTrip: removed.isRoundTrip,
        ),
      );
      update();
      AppSnackbar.success(
        title: 'Booking Cancelled',
        message: 'Your ride booking $id has been cancelled.',
      );
    }
  }
}

