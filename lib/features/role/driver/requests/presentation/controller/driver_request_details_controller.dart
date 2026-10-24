import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class RiderModel {
  final String name;
  final String grade;
  final String avatarUrl;
  final String initials;

  const RiderModel({
    required this.name,
    required this.grade,
    required this.avatarUrl,
    required this.initials,
  });
}

class DriverRequestDetailsController extends GetxController {
  static DriverRequestDetailsController get instance =>
      Get.find<DriverRequestDetailsController>();

  String parentName = 'Amanda Roy';
  String parentRole = 'Parent/Guardian';
  bool isVerified = true;
  String parentAvatarUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=150&q=80';

  final List<RiderModel> riders = const [
    RiderModel(
      name: 'Noah Roy',
      grade: 'Grade 3',
      avatarUrl:
          'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?auto=format&fit=crop&w=150&q=80',
      initials: 'NR',
    ),
    RiderModel(
      name: 'Olivia Roy',
      grade: 'Grade 1',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=150&q=80',
      initials: 'OR',
    ),
  ];

  String pickupAddress = '18 Maple Avenue';
  String pickupLabel = 'Pickup (Home)';
  String destinationAddress = 'Greenfield International School';
  String destinationLabel = 'Drop-off (School)';

  String morningTitle = 'Morning pickup';
  String morningTime = '07:45 AM';
  String afternoonTitle = 'Afternoon return';
  String afternoonTime = '03:10 PM';

  String specialNotes =
      'Booster seat for Noah. Hand both children to the Greenfield loop supervisor.';

  String earningsAmount = '\$120';
  String earningsPeriod = '/ Month';

  String complianceNotice =
      'Approve docs first: Licence, Insurance, Vehicle Registration, CBC, Vulnerable Sector';

  String status = 'pending'; // 'pending', 'accepted', 'declined'

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args['parentName'] != null) parentName = args['parentName'];
      if (args['price'] != null) {
        final parts = (args['price'] as String).split('/');
        earningsAmount = parts.first.trim();
        if (parts.length > 1) {
          earningsPeriod = '/ ${parts[1].trim()}';
        }
      }
      if (args['pickupAddress'] != null) pickupAddress = args['pickupAddress'];
      if (args['destinationAddress'] != null) {
        destinationAddress = args['destinationAddress'];
      }
    }
  }

  void acceptRequest() {
    status = 'accepted';
    update();
    AppSnackbar.success(
      title: 'Request Accepted',
      message: 'You accepted the request from $parentName',
    );
    Future.delayed(const Duration(milliseconds: 1200), () {
      Get.back();
    });
  }

  void declineRequest() {
    status = 'declined';
    update();
    AppSnackbar.error(
      title: 'Request Declined',
      message: 'Request from $parentName was declined',
    );
    Future.delayed(const Duration(milliseconds: 1200), () {
      Get.back();
    });
  }

  void openChat() {
    Get.toNamed(AppRoutes.message);
  }
}
