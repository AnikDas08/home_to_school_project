import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class WalkshareRequestItem {
  final String id;
  final String initials;
  final String parentName;
  final String childrenInfo;
  final String price;
  final String pickupAddress;
  final String destinationAddress;
  final String scheduleDays;
  final String scheduleTime;
  final String tripType;
  final String seats;
  String status; // 'pending', 'accepted', 'declined'

  WalkshareRequestItem({
    required this.id,
    required this.initials,
    required this.parentName,
    required this.childrenInfo,
    required this.price,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.scheduleDays,
    required this.scheduleTime,
    required this.tripType,
    required this.seats,
    this.status = 'pending',
  });
}

class WalkshareRequestsController extends GetxController {
  static WalkshareRequestsController get instance =>
      Get.find<WalkshareRequestsController>();

  final List<WalkshareRequestItem> requests = [
    WalkshareRequestItem(
      id: '1',
      initials: 'NR',
      parentName: 'Nadia Rahman',
      childrenInfo: 'Yusuf (Gr 3) • Ayla (Gr 1)',
      price: '\$120 / Month',
      pickupAddress: '18 Maple Avenue',
      destinationAddress: 'Greenfield International School',
      scheduleDays: 'Mon-Fri',
      scheduleTime: '07:45 AM & 03:10 PM',
      tripType: 'Recurring',
      seats: '2 seats',
    ),
    WalkshareRequestItem(
      id: '2',
      initials: 'SK',
      parentName: 'Sadia Khan',
      childrenInfo: 'Zara (Pre-K)',
      price: '\$45 /Month',
      pickupAddress: 'Home (12 Elm Street)',
      destinationAddress: 'Sunshine Pre-school',
      scheduleDays: 'Thursday, Sep 17',
      scheduleTime: '08:15 AM & 01:30 PM',
      tripType: 'One-time',
      seats: '1 seat',
    ),
  ];

  void onRequestItemTap(WalkshareRequestItem item) {
    Get.toNamed(AppRoutes.walkshareRequestDetails);
  }

  void acceptRequest(String id) {
    final index = requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      final name = requests[index].parentName;
      requests[index].status = 'accepted';
      update();

      AppSnackbar.success(
        title: 'Request Accepted',
        message: 'You have accepted the walk request from $name.',
      );
    }
  }

  void declineRequest(String id) {
    final index = requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      final name = requests[index].parentName;
      requests.removeAt(index);
      update();

      AppSnackbar.success(
        title: 'Request Declined',
        message: 'The walk request from $name was declined.',
      );
    }
  }
}
