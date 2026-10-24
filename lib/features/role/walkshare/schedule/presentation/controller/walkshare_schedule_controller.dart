import 'package:get/get.dart';
import 'package:home_to_school/features/role/walkshare/schedule/presentation/widgets/walkshare_trip_card.dart';

class WalkshareScheduleTripModel {
  final String month;
  final String day;
  final String weekday;
  final String timeText;
  final String pickupAddress;
  final String destinationAddress;
  final WalkBadgeType badgeType;

  const WalkshareScheduleTripModel({
    required this.month,
    required this.day,
    required this.weekday,
    required this.timeText,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.badgeType,
  });
}

class WalkshareScheduleController extends GetxController {
  static WalkshareScheduleController get instance =>
      Get.find<WalkshareScheduleController>();

  final List<WalkshareScheduleTripModel> scheduledTrips = const [
    WalkshareScheduleTripModel(
      month: 'MAY',
      day: '22',
      weekday: 'Wed',
      timeText: '07:30 AM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: WalkBadgeType.oneWay,
    ),
    WalkshareScheduleTripModel(
      month: 'MAY',
      day: '23',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: WalkBadgeType.roundTrip,
    ),
    WalkshareScheduleTripModel(
      month: 'MAY',
      day: '24',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: WalkBadgeType.roundTrip,
    ),
    WalkshareScheduleTripModel(
      month: 'MAY',
      day: '25',
      weekday: 'Wed',
      timeText: '07:30 AM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: WalkBadgeType.oneWay,
    ),
    WalkshareScheduleTripModel(
      month: 'MAY',
      day: '27',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: WalkBadgeType.roundTrip,
    ),
    WalkshareScheduleTripModel(
      month: 'MAY',
      day: '28',
      weekday: 'Wed',
      timeText: '07:30 AM & 01:00 PM',
      pickupAddress: '9 Harbourview Lane',
      destinationAddress: 'Greenfield International',
      badgeType: WalkBadgeType.roundTrip,
    ),
  ];
}
