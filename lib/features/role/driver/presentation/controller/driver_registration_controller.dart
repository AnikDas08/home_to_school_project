import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class DriverRegistrationController extends GetxController {
  static DriverRegistrationController get instance =>
      Get.find<DriverRegistrationController>();

  final ImagePicker _picker = ImagePicker();

  // ==========================================
  // SCREEN 1: DRIVER'S LICENCE
  // ==========================================
  final TextEditingController licenceNumberController = TextEditingController();

  String? licenceClass;
  String? issuingProvince;
  DateTime? expiryDate;
  String? frontLicenceFileName;
  String? backLicenceFileName;

  final List<String> licenceClasses = const [
    'Class G (Full Licence)',
    'Class G2',
    'Class 4 (Commercial)',
    'Class 5',
    'Class 1 (Heavy Trailer)',
  ];

  final List<String> provinces = const [
    'Ontario',
    'British Columbia',
    'Alberta',
    'Quebec',
    'Manitoba',
    'Saskatchewan',
    'Nova Scotia',
    'New Brunswick',
  ];

  void setLicenceClass(String value) {
    licenceClass = value;
    update();
  }

  void setIssuingProvince(String value) {
    issuingProvince = value;
    update();
  }

  void setExpiryDate(DateTime date) {
    expiryDate = date;
    update();
  }

  String _formatFileName(String rawName) {
    String name = rawName.split('/').last;
    if (name.contains(String.fromCharCode(92))) {
      name = name.split(String.fromCharCode(92)).last;
    }
    if (name.isEmpty) return 'licence_image.jpg';
    if (name.length > 25) {
      final extIndex = name.lastIndexOf('.');
      if (extIndex != -1 && extIndex < name.length) {
        final ext = name.substring(extIndex);
        final base = name.substring(0, extIndex);
        return '${base.substring(0, 16.clamp(0, base.length))}...$ext';
      }
      return '${name.substring(0, 20)}...';
    }
    return name;
  }

  Future<void> pickFrontLicence() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        frontLicenceFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      frontLicenceFileName = 'licence_front.jpg';
      update();
    }
  }

  Future<void> pickBackLicence() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        backLicenceFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      backLicenceFileName = 'licence_back.jpg';
      update();
    }
  }

  void submitLicence() {
    Get.toNamed(AppRoutes.driverVehicleDetails);
  }

  // ==========================================
  // SCREEN 2: VEHICLE DETAILS
  // ==========================================
  String vehicleType = 'Minivan';

  final List<String> vehicleTypes = const [
    'Minivan',
    'Sedan',
    'SUV',
    'Van',
    'Hatchback',
  ];

  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController colourController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();

  String? vehiclePhotoFileName;

  void setVehicleType(String type) {
    vehicleType = type;
    update();
  }

  Future<void> pickVehiclePhoto() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        vehiclePhotoFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      vehiclePhotoFileName = 'vehicle_exterior.jpg';
      update();
    }
  }

  void submitVehicleDetails() {
    AppSnackbar.success(
      title: 'Success',
      message: 'Driver registration details submitted successfully!',
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAllNamed(AppRoutes.navScreen);
    });
  }

  @override
  void onClose() {
    licenceNumberController.dispose();
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    colourController.dispose();
    plateController.dispose();
    seatsController.dispose();
    super.onClose();
  }
}
