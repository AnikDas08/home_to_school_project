import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class DriverRequestItem {
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

  DriverRequestItem({
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

class DriverRequestsController extends GetxController {
  static DriverRequestsController get instance =>
      Get.find<DriverRequestsController>();

  final List<DriverRequestItem> requests = [
    DriverRequestItem(
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
    DriverRequestItem(
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

  void acceptRequest(String id) {
    final index = requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      requests[index].status = 'accepted';
      update();
      AppSnackbar.success(
        title: 'Request Accepted',
        message: 'You accepted the ride request from ${requests[index].parentName}',
      );
    }
  }

  void declineRequest(String id) {
    final index = requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      requests[index].status = 'declined';
      update();
      AppSnackbar.error(
        title: 'Request Declined',
        message: 'Ride request from ${requests[index].parentName} was declined',
      );
    }
  }

  void onRequestItemTap(DriverRequestItem item) {
    Get.toNamed(
      AppRoutes.driverRequestDetails,
      arguments: {
        'parentName': item.parentName,
        'price': item.price,
        'pickupAddress': item.pickupAddress,
        'destinationAddress': item.destinationAddress,
      },
    );
  }
}
