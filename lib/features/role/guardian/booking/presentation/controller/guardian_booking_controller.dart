import 'package:get/get.dart';

enum BookingBadgeType { oneWay, roundTrip }

enum BookingTabType { upcoming, history, cancelled }

enum BookingActionType { track, details, rateAndRebook, rebookOnly }

class GuardianBookingModel {
  final String id;
  final String date;
  final String time;
  final BookingBadgeType badgeType;
  final String pickup;
  final String destination;
  final String price;
  final String driverName;
  final String driverRating;
  final String? driverImage;
  final BookingTabType tabType;
  final bool isActiveTrip;
  final BookingActionType actionType;

  const GuardianBookingModel({
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

class GuardianBookingController extends GetxController {
  static GuardianBookingController get instance =>
      Get.find<GuardianBookingController>();

  /// 0 = Upcoming (6), 1 = History (4), 2 = Cancelled (3)
  int selectedTabIndex = 0;

  void selectTab(int index) {
    if (selectedTabIndex == index) return;
    selectedTabIndex = index;
    update();
  }

  /// Upcoming Bookings (Total 6)
  final List<GuardianBookingModel> upcomingBookings = const [
    // Active trip right now 1
    GuardianBookingModel(
      id: 'up_1',
      date: 'May 20, 2026',
      time: '07:30 AM & 01:00 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '135',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: BookingTabType.upcoming,
      isActiveTrip: true,
      actionType: BookingActionType.track,
    ),
    // Active trip right now 2
    GuardianBookingModel(
      id: 'up_2',
      date: 'May 21, 2026',
      time: '07:45 AM',
      badgeType: BookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '85',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: BookingTabType.upcoming,
      isActiveTrip: true,
      actionType: BookingActionType.track,
    ),
    // Scheduled commutes 1
    GuardianBookingModel(
      id: 'up_3',
      date: 'May 22, 2026',
      time: '07:45 AM',
      badgeType: BookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '135',
      driverName: 'Farhana Yasmin',
      driverRating: '5',
      tabType: BookingTabType.upcoming,
      isActiveTrip: false,
      actionType: BookingActionType.details,
    ),
    // Scheduled commutes 2
    GuardianBookingModel(
      id: 'up_4',
      date: 'May 23, 2026',
      time: '08:30 AM & 02:30 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Sunshine Pre-school',
      price: '55',
      driverName: 'Kabir Hossain',
      driverRating: '4.8',
      tabType: BookingTabType.upcoming,
      isActiveTrip: false,
      actionType: BookingActionType.details,
    ),
    // Scheduled commutes 3
    GuardianBookingModel(
      id: 'up_5',
      date: 'May 24, 2026',
      time: '08:00 AM',
      badgeType: BookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '65',
      driverName: 'Farhana Yasmin',
      driverRating: '5',
      tabType: BookingTabType.upcoming,
      isActiveTrip: false,
      actionType: BookingActionType.details,
    ),
    // Scheduled commutes 4
    GuardianBookingModel(
      id: 'up_6',
      date: 'May 25, 2026',
      time: '08:30 AM & 02:30 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Sunshine Pre-school',
      price: '55',
      driverName: 'Kabir Hossain',
      driverRating: '4.8',
      tabType: BookingTabType.upcoming,
      isActiveTrip: false,
      actionType: BookingActionType.details,
    ),
  ];

  /// History Bookings (Total 4)
  final List<GuardianBookingModel> historyBookings = const [
    GuardianBookingModel(
      id: 'hist_1',
      date: 'May 14, 2026',
      time: '07:30 AM & 01:00 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '120',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: BookingTabType.history,
      actionType: BookingActionType.rateAndRebook,
    ),
    GuardianBookingModel(
      id: 'hist_2',
      date: 'May 18, 2026',
      time: '08:15 AM',
      badgeType: BookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Sunshine Pre-school',
      price: '35',
      driverName: 'Sarah Jenkins',
      driverRating: '4.9',
      tabType: BookingTabType.history,
      actionType: BookingActionType.rateAndRebook,
    ),
    GuardianBookingModel(
      id: 'hist_3',
      date: 'May 12, 2026',
      time: '08:00 AM & 03:00 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '50',
      driverName: 'Farhana Yasmin',
      driverRating: '5',
      tabType: BookingTabType.history,
      actionType: BookingActionType.rateAndRebook,
    ),
    GuardianBookingModel(
      id: 'hist_4',
      date: 'April 28, 2026',
      time: '07:45 AM',
      badgeType: BookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Sunshine Pre-school',
      price: '65',
      driverName: 'Sarah Jenkins',
      driverRating: '4.9',
      tabType: BookingTabType.history,
      actionType: BookingActionType.rateAndRebook,
    ),
  ];

  /// Cancelled Bookings (Total 3)
  final List<GuardianBookingModel> cancelledBookings = const [
    GuardianBookingModel(
      id: 'canc_1',
      date: 'May 08, 2026',
      time: '08:15 AM',
      badgeType: BookingBadgeType.oneWay,
      pickup: 'Home (12 Elm Street)',
      destination: 'Sunshine Pre-school',
      price: '35',
      driverName: 'Sarah Jenkins',
      driverRating: '4.9',
      tabType: BookingTabType.cancelled,
      actionType: BookingActionType.rebookOnly,
    ),
    GuardianBookingModel(
      id: 'canc_2',
      date: 'May 02, 2026',
      time: '07:30 AM & 01:00 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Greenfield International School',
      price: '120',
      driverName: 'Tariq Ahmed',
      driverRating: '4.9',
      tabType: BookingTabType.cancelled,
      actionType: BookingActionType.rebookOnly,
    ),
    GuardianBookingModel(
      id: 'canc_3',
      date: 'Sep 7, 2026',
      time: '08:15 AM & 01:30 PM',
      badgeType: BookingBadgeType.roundTrip,
      pickup: 'Home (12 Elm Street)',
      destination: 'Sunshine Pre-school',
      price: '35',
      driverName: 'Sarah Jenkins',
      driverRating: '4.9',
      tabType: BookingTabType.cancelled,
      actionType: BookingActionType.rebookOnly,
    ),
  ];

  /// Active trips for Upcoming tab
  List<GuardianBookingModel> get activeTrips =>
      upcomingBookings.where((b) => b.isActiveTrip).toList();

  /// Scheduled commutes for Upcoming tab
  List<GuardianBookingModel> get scheduledCommutes =>
      upcomingBookings.where((b) => !b.isActiveTrip).toList();
}
