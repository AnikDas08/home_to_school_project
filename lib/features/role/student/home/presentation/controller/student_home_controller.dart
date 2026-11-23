import 'package:get/get.dart';
import 'package:home_to_school/services/storage/storage_services.dart';

class StudentHomeController extends GetxController {
  static StudentHomeController get instance => Get.find<StudentHomeController>();

  int currentNavIndex = 0;
  String studentName = 'Alex Morgan';
  String institutionName = 'Seneca College';
  String campusName = 'Newnham Campus';
  bool isVerified = true;

  @override
  void onInit() {
    super.onInit();
    syncStudentData();
  }

  void syncStudentData() {
    if (LocalStorage.myName.isNotEmpty) {
      studentName = LocalStorage.myName;
    } else if (LocalStorage.user?.name.isNotEmpty == true) {
      studentName = LocalStorage.user!.name;
    }
    update();
  }

  void changeNavIndex(int index) {
    currentNavIndex = index;
    update();
  }
}

