import 'package:get/get.dart';

enum StudentBookingBadgeType { oneWay, roundTrip }

enum StudentBookingTabType { upcoming, history, cancelled }

enum StudentBookingActionType { track, details, rateAndRebook, rebookOnly }

class StudentBookingItem {
  final String id;
  final String date;
  final String time;
  final StudentBookingBadgeType badgeType;
  final String pickup;
  final String destination;
  final String price;
  final String driverName;
  final String driverRating;
  final String? driverImage;
  final StudentBookingTabType tabType;
  final bool isActiveTrip;
  final StudentBookingActionType actionType;

  const StudentBookingItem({
    required this.id,
    required this.date,
    required this.time,
    required this.badgeType,
    required this.pickup,
    required this.destination,
    required this.price,
    required this.driverName,
    required this.driverRating,
    this.driverImage,
    required this.tabType,
    this.isActiveTrip = false,
    required this.actionType,
  });
}

class StudentBookingsController extends GetxController {
  static StudentBookingsController get instance =>
      Get.find<StudentBookingsController>();

  /// 0 = Upcoming (4), 1 = History (3), 2 = Cancelled (2)
  int selectedTabIndex = 0;

  void selectTab(int index) {
    if (selectedTabIndex == index) return;
    selectedTabIndex = index;
    update();
  }

  /// Upcoming Bookings
  final List<StudentBookingItem> upcomingBookings = const [
    StudentBookingItem(
      id: 'sb_up_1',
      date: 'May 20, 2026',
      time: '07:30 AM & 01:00 PM',
      badgeType: StudentBookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Seneca College - Newnham Campus',
      price: '135',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: StudentBookingTabType.upcoming,
      isActiveTrip: true,
      actionType: StudentBookingActionType.track,
    ),
    StudentBookingItem(
      id: 'sb_up_2',
      date: 'May 21, 2026',
      time: '07:45 AM',
      badgeType: StudentBookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Seneca College - Newnham Campus',
      price: '85',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: StudentBookingTabType.upcoming,
      isActiveTrip: true,
      actionType: StudentBookingActionType.track,
    ),
    StudentBookingItem(
      id: 'sb_up_3',
      date: 'May 22, 2026',
      time: '07:45 AM',
      badgeType: StudentBookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Seneca College - Newnham Campus',
      price: '135',
      driverName: 'Farhana Yasmin',
      driverRating: '5.0',
      tabType: StudentBookingTabType.upcoming,
      isActiveTrip: false,
      actionType: StudentBookingActionType.details,
    ),
    StudentBookingItem(
      id: 'sb_up_4',
      date: 'May 24, 2026',
      time: '08:30 AM & 02:30 PM',
      badgeType: StudentBookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'York University - Student Centre',
      price: '65',
      driverName: 'Kabir Hossain',
      driverRating: '4.8',
      tabType: StudentBookingTabType.upcoming,
      isActiveTrip: false,
      actionType: StudentBookingActionType.details,
    ),
  ];

  /// History Bookings
  final List<StudentBookingItem> historyBookings = const [
    StudentBookingItem(
      id: 'sb_hist_1',
      date: 'May 18, 2026',
      time: '08:00 AM',
      badgeType: StudentBookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Seneca College - Newnham Campus',
      price: '85',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: StudentBookingTabType.history,
      actionType: StudentBookingActionType.rateAndRebook,
    ),
    StudentBookingItem(
      id: 'sb_hist_2',
      date: 'May 15, 2026',
      time: '07:30 AM & 01:00 PM',
      badgeType: StudentBookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Seneca College - Newnham Campus',
      price: '135',
      driverName: 'Farhana Yasmin',
      driverRating: '5.0',
      tabType: StudentBookingTabType.history,
      actionType: StudentBookingActionType.rebookOnly,
    ),
    StudentBookingItem(
      id: 'sb_hist_3',
      date: 'May 12, 2026',
      time: '08:30 AM',
      badgeType: StudentBookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'York University - Student Centre',
      price: '55',
      driverName: 'Kabir Hossain',
      driverRating: '4.8',
      tabType: StudentBookingTabType.history,
      actionType: StudentBookingActionType.rebookOnly,
    ),
  ];

  /// Cancelled Bookings
  final List<StudentBookingItem> cancelledBookings = const [
    StudentBookingItem(
      id: 'sb_can_1',
      date: 'May 10, 2026',
      time: '08:00 AM',
      badgeType: StudentBookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Seneca College - Newnham Campus',
      price: '85',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: StudentBookingTabType.cancelled,
      actionType: StudentBookingActionType.rebookOnly,
    ),
  ];

  List<StudentBookingItem> get activeTrips =>
      upcomingBookings.where((b) => b.isActiveTrip).toList();

  List<StudentBookingItem> get scheduledCommutes =>
      upcomingBookings.where((b) => !b.isActiveTrip).toList();
}
