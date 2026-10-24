import 'package:get/get.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class DriverHomeController extends GetxController {
  static DriverHomeController get instance => Get.find<DriverHomeController>();

  String get userName {
    if (LocalStorage.user?.name.isNotEmpty == true) {
      return LocalStorage.user!.name;
    }
    if (LocalStorage.myName.isNotEmpty) {
      return LocalStorage.myName;
    }
    return 'John';
  }

  bool isAvailable = true;

  void toggleAvailability() {
    isAvailable = !isAvailable;
    update();
    AppSnackbar.success(
      title: 'Status Updated',
      message: isAvailable
          ? 'You are now available for ride requests'
          : 'You are now offline / unavailable',
    );
  }

  void onRequestsTap() {
    Get.toNamed(AppRoutes.driverRequests);
  }

  void onAvailabilityTap() {
    Get.toNamed(AppRoutes.driverAvailability);
  }

  void onSeeAllTrips() {
    Get.toNamed(AppRoutes.driverSchedule);
  }
}
