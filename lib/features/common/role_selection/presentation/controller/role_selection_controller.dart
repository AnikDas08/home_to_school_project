import 'package:get/get.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_up/controller/sign_up_controller.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/constants/app_string.dart';

enum RoleIconType { parent, driver, walkShare }

class RoleOption {
  final String title;
  final String subtitle;
  final RoleIconType iconType;

  const RoleOption({
    required this.title,
    required this.subtitle,
    required this.iconType,
  });
}

class RoleSelectionController extends GetxController {
  int selectedIndex = 0;

  final List<RoleOption> roles = const [
    RoleOption(
      title: AppString.parentGuardian,
      subtitle: AppString.parentGuardianDesc,
      iconType: RoleIconType.parent,
    ),
    RoleOption(
      title: AppString.driverCarpool,
      subtitle: AppString.driverCarpoolDesc,
      iconType: RoleIconType.driver,
    ),
    RoleOption(
      title: AppString.walkShare,
      subtitle: AppString.walkShareDesc,
      iconType: RoleIconType.walkShare,
    ),
  ];

  String get selectedRoleTitle => roles[selectedIndex].title;

  @override
  void onInit() {
    super.onInit();
    // Default selected role saved to LocalStorage
    _syncRoleToStorage(roles[selectedIndex].title);
  }

  void selectRole(int index) {
    selectedIndex = index;
    update();
    _syncRoleToStorage(roles[index].title);
  }

  Future<void> _syncRoleToStorage(String roleTitle) async {
    LocalStorage.role = roleTitle;
    LocalStorage.myRole = roleTitle;
    await LocalStorage.saveRole(roleTitle);
  }

  void continueToSignUp() {
    final role = selectedRoleTitle;
    _syncRoleToStorage(role);

    if (Get.isRegistered<SignUpController>()) {
      Get.find<SignUpController>().setSelectedRole(role);
    }

    Get.toNamed(AppRoutes.signUp, arguments: {'role': role});
  }
}
