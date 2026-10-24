import 'package:get/get.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_trip_card.dart';

class DriverScheduleTripModel {
  final String month;
  final String day;
  final String weekday;
  final String timeText;
  final String pickupAddress;
  final String destinationAddress;
  final TripBadgeType badgeType;

  const DriverScheduleTripModel({
    required this.month,
    required this.day,
    required this.weekday,
    required this.timeText,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.badgeType,
  });
}

class DriverScheduleController extends GetxController {
  static DriverScheduleController get instance =>
      Get.find<DriverScheduleController>();

  final List<DriverScheduleTripModel> scheduledTrips = const [
    DriverScheduleTripModel(
      month: 'MAY',
      day: '22',
      weekday: 'Wed',
      timeText: '07:30 AM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: TripBadgeType.oneWay,
    ),
    DriverScheduleTripModel(
      month: 'MAY',
      day: '23',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: TripBadgeType.roundTrip,
    ),
    DriverScheduleTripModel(
      month: 'MAY',
      day: '24',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: TripBadgeType.roundTrip,
    ),
    DriverScheduleTripModel(
      month: 'MAY',
      day: '25',
      weekday: 'Wed',
      timeText: '07:30 AM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: TripBadgeType.oneWay,
    ),
    DriverScheduleTripModel(
      month: 'MAY',
      day: '27',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: TripBadgeType.roundTrip,
    ),
    DriverScheduleTripModel(
      month: 'MAY',
      day: '28',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: TripBadgeType.roundTrip,
    ),
  ];
}
