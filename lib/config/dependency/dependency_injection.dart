import 'package:get/get.dart';

import 'package:home_to_school/features/common/auth/presentation/change_password/controller/change_password_controller.dart';
import 'package:home_to_school/features/common/auth/presentation/forgot_password/controller/forget_password_controller.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_in/controller/sign_in_controller.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_up/controller/sign_up_controller.dart';
import 'package:home_to_school/features/message/presentation/chat_list/controller/chat_controller.dart';
import 'package:home_to_school/features/message/presentation/message_details/controller/message_controller.dart';
import '../../features/common/nav_screen/controller/nav_controller.dart';
import '../../features/common/role_selection/presentation/controller/role_selection_controller.dart';
import '../../features/notifications/presentation/controller/notifications_controller.dart';
import '../../features/profile/presentation/controller/profile_controller.dart';
import '../../features/role/guardian/booking/presentation/controller/guardian_booking_controller.dart';
import '../../features/role/guardian/profile/presentation/controller/guardian_profile_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavController(), fenix: true);
    Get.lazyPut(() => GuardianBookingController(), fenix: true);
    Get.lazyPut(() => GuardianProfileController(), fenix: true);
    Get.lazyPut(() => RoleSelectionController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
