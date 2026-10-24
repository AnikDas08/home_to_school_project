import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class StudentRiderModel {
  final String name;
  final String grade;
  final String avatarUrl;
  final String initials;

  const StudentRiderModel({
    required this.name,
    required this.grade,
    this.avatarUrl = '',
    this.initials = '',
  });
}

class WalkshareRequestDetailsController extends GetxController {
  static WalkshareRequestDetailsController get instance =>
      Get.find<WalkshareRequestDetailsController>();

  final String parentName = 'Amanda Roy';
  final String parentRole = 'Parent/Guardian';
  final bool isVerified = true;
  final String parentAvatarUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=150&q=80';

  final List<StudentRiderModel> riders = const [
    StudentRiderModel(
      name: 'Noah Roy',
      grade: 'Grade 3',
      avatarUrl:
          'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?auto=format&fit=crop&w=150&q=80',
      initials: 'NR',
    ),
    StudentRiderModel(
      name: 'Olivia Roy',
      grade: 'Grade 1',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=150&q=80',
      initials: 'OR',
    ),
  ];

  final String pickupAddress = '18 Maple Avenue';
  final String pickupLabel = 'Pickup (Home)';
  final String destinationAddress = 'Greenfield International School';
  final String destinationLabel = 'Drop-off (School)';

  final String morningTitle = 'Morning pickup';
  final String morningTime = '07:45 AM';
  final String afternoonTitle = 'Afternoon return';
  final String afternoonTime = '03:10 PM';

  final String specialNotes =
      'Booster seat for Noah. Hand both children to the Greenfield loop supervisor.';

  final String earningsAmount = '\$120';
  final String earningsPeriod = '/ Month';

  final String complianceNotice =
      'Approve docs first: Licence, Insurance, Registration, CBC, Vulnerable Sector';

  void openChat() {
    Get.toNamed(AppRoutes.message);
  }

  void acceptRequest() {
    AppSnackbar.success(
      title: 'Request Accepted',
      message: 'You have accepted Amanda Roy\'s walk request.',
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.back();
    });
  }

  void declineRequest() {
    AppSnackbar.success(
      title: 'Request Declined',
      message: 'Walk request has been declined.',
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.back();
    });
  }
}
