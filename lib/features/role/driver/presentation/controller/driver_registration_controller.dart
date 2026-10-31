import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  /// 4 Required Vehicle Photos (Front, Back, Left, Right)
  File? frontVehiclePhoto;
  String? frontVehiclePhotoName;

  File? backVehiclePhoto;
  String? backVehiclePhotoName;

  File? leftVehiclePhoto;
  String? leftVehiclePhotoName;

  File? rightVehiclePhoto;
  String? rightVehiclePhotoName;

  /// Optional Additional Vehicle Photos (Interior, Back seats, Trunk, Dashboard, etc.)
  final List<File> additionalVehiclePhotos = [];
  final List<String> additionalVehiclePhotoNames = [];

  /// Backward-compatible single photo getter
  String? get vehiclePhotoFileName => frontVehiclePhotoName;
  set vehiclePhotoFileName(String? val) {
    frontVehiclePhotoName = val;
  }

  void setVehicleType(String type) {
    vehicleType = type;
    update();
  }

  /// Returns whether a specific angle has an uploaded photo
  bool hasPhotoForAngle(String angle) {
    switch (angle.toLowerCase()) {
      case 'front':
        return frontVehiclePhoto != null || frontVehiclePhotoName != null;
      case 'back':
        return backVehiclePhoto != null || backVehiclePhotoName != null;
      case 'left':
        return leftVehiclePhoto != null || leftVehiclePhotoName != null;
      case 'right':
        return rightVehiclePhoto != null || rightVehiclePhotoName != null;
      default:
        return false;
    }
  }

  /// Returns the File object for an angle
  File? getPhotoForAngle(String angle) {
    switch (angle.toLowerCase()) {
      case 'front':
        return frontVehiclePhoto;
      case 'back':
        return backVehiclePhoto;
      case 'left':
        return leftVehiclePhoto;
      case 'right':
        return rightVehiclePhoto;
      default:
        return null;
    }
  }

  /// Returns the file name for an angle
  String? getPhotoNameForAngle(String angle) {
    switch (angle.toLowerCase()) {
      case 'front':
        return frontVehiclePhotoName;
      case 'back':
        return backVehiclePhotoName;
      case 'left':
        return leftVehiclePhotoName;
      case 'right':
        return rightVehiclePhotoName;
      default:
        return null;
    }
  }

  /// Count of uploaded vehicle photos (minimum 4 required)
  int get uploadedVehiclePhotosCount {
    int count = 0;
    if (hasPhotoForAngle('front')) count++;
    if (hasPhotoForAngle('back')) count++;
    if (hasPhotoForAngle('left')) count++;
    if (hasPhotoForAngle('right')) count++;
    return count;
  }

  /// Check whether all 4 required vehicle photos are uploaded
  bool get hasAllVehiclePhotos => uploadedVehiclePhotosCount >= 4;

  /// Pick photo for a specific angle (Camera or Gallery)
  Future<void> pickVehicleAnglePhoto({
    required String angle,
    required ImageSource source,
  }) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        final pickedFile = File(file.path);
        final formattedName = _formatFileName(file.name);

        switch (angle.toLowerCase()) {
          case 'front':
            frontVehiclePhoto = pickedFile;
            frontVehiclePhotoName = formattedName;
            break;
          case 'back':
            backVehiclePhoto = pickedFile;
            backVehiclePhotoName = formattedName;
            break;
          case 'left':
            leftVehiclePhoto = pickedFile;
            leftVehiclePhotoName = formattedName;
            break;
          case 'right':
            rightVehiclePhoto = pickedFile;
            rightVehiclePhotoName = formattedName;
            break;
        }
        update();
      }
    } catch (_) {
      final defaultName = 'vehicle_${angle.toLowerCase()}.jpg';
      switch (angle.toLowerCase()) {
        case 'front':
          frontVehiclePhotoName = defaultName;
          break;
        case 'back':
          backVehiclePhotoName = defaultName;
          break;
        case 'left':
          leftVehiclePhotoName = defaultName;
          break;
        case 'right':
          rightVehiclePhotoName = defaultName;
          break;
      }
      update();
    }
  }

  /// Remove photo for a specific angle
  void removeVehicleAnglePhoto(String angle) {
    switch (angle.toLowerCase()) {
      case 'front':
        frontVehiclePhoto = null;
        frontVehiclePhotoName = null;
        break;
      case 'back':
        backVehiclePhoto = null;
        backVehiclePhotoName = null;
        break;
      case 'left':
        leftVehiclePhoto = null;
        leftVehiclePhotoName = null;
        break;
      case 'right':
        rightVehiclePhoto = null;
        rightVehiclePhotoName = null;
        break;
    }
    update();
  }

  /// Total count of all uploaded photos (4 required + any additional optional)
  int get totalVehiclePhotosCount =>
      uploadedVehiclePhotosCount + additionalVehiclePhotos.length;

  /// Add an additional optional photo (e.g. interior, dashboard, booster seats)
  Future<void> addAdditionalVehiclePhoto(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        additionalVehiclePhotos.add(File(file.path));
        additionalVehiclePhotoNames.add(_formatFileName(file.name));
        update();
      }
    } catch (_) {
      additionalVehiclePhotos.add(File('vehicle_extra_${additionalVehiclePhotos.length + 1}.jpg'));
      additionalVehiclePhotoNames.add('vehicle_extra_${additionalVehiclePhotos.length + 1}.jpg');
      update();
    }
  }

  /// Remove an additional optional photo by index
  void removeAdditionalVehiclePhoto(int index) {
    if (index >= 0 && index < additionalVehiclePhotos.length) {
      additionalVehiclePhotos.removeAt(index);
      if (index < additionalVehiclePhotoNames.length) {
        additionalVehiclePhotoNames.removeAt(index);
      }
      update();
    }
  }

  /// Legacy single-photo picker (falls back to front photo)
  Future<void> pickVehiclePhoto() async {
    await pickVehicleAnglePhoto(
      angle: 'front',
      source: ImageSource.gallery,
    );
  }

  void submitVehicleDetails() {
    // Validate that minimum 4 vehicle photos are provided
    final missingAngles = <String>[];
    if (!hasPhotoForAngle('front')) missingAngles.add('Front');
    if (!hasPhotoForAngle('back')) missingAngles.add('Back');
    if (!hasPhotoForAngle('left')) missingAngles.add('Left');
    if (!hasPhotoForAngle('right')) missingAngles.add('Right');

    if (missingAngles.isNotEmpty) {
      AppSnackbar.error(
        title: 'Vehicle Photos Required',
        message:
            'Please upload all 4 vehicle photos (missing: ${missingAngles.join(', ')} side).',
      );
      return;
    }

    // Navigate to Step 3: Vehicle Insurance, VSC & Registration Screen
    Get.toNamed(AppRoutes.driverVehicleInsurance);
  }

  // ==========================================
  // SCREEN 3: VEHICLE INSURANCE, VSC & REGISTRATION
  // ==========================================
  final TextEditingController insuranceProviderController = TextEditingController();
  final TextEditingController insuranceNumberController = TextEditingController();
  DateTime? insuranceExpiryDate;
  File? insuranceDocumentPhoto;
  String? insuranceDocumentFileName;

  final TextEditingController vulnerabilityNumberController = TextEditingController();
  DateTime? vulnerabilityDate;
  File? vulnerabilityDocumentPhoto;
  String? vulnerabilityDocumentFileName;

  File? registrationDocumentPhoto;
  String? registrationDocumentFileName;

  void setInsuranceExpiryDate(DateTime date) {
    insuranceExpiryDate = date;
    update();
  }

  Future<void> pickInsuranceDocument(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        insuranceDocumentPhoto = File(file.path);
        insuranceDocumentFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      insuranceDocumentFileName = 'vehicle_insurance.jpg';
      update();
    }
  }

  void removeInsuranceDocument() {
    insuranceDocumentPhoto = null;
    insuranceDocumentFileName = null;
    update();
  }

  void setVulnerabilityDate(DateTime date) {
    vulnerabilityDate = date;
    update();
  }

  Future<void> pickVulnerabilityDocument(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        vulnerabilityDocumentPhoto = File(file.path);
        vulnerabilityDocumentFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      vulnerabilityDocumentFileName = 'vsc_clearance.jpg';
      update();
    }
  }

  void removeVulnerabilityDocument() {
    vulnerabilityDocumentPhoto = null;
    vulnerabilityDocumentFileName = null;
    update();
  }

  Future<void> pickRegistrationDocument(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        registrationDocumentPhoto = File(file.path);
        registrationDocumentFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      registrationDocumentFileName = 'vehicle_registration.jpg';
      update();
    }
  }

  void removeRegistrationDocument() {
    registrationDocumentPhoto = null;
    registrationDocumentFileName = null;
    update();
  }

  void submitAllDocuments() {
    final missing = <String>[];

    if (insuranceNumberController.text.trim().isEmpty) {
      missing.add('Insurance Policy Number');
    }
    if (insuranceExpiryDate == null) {
      missing.add('Insurance Expiry Date');
    }
    if (insuranceDocumentPhoto == null && insuranceDocumentFileName == null) {
      missing.add('Insurance Document Photo');
    }
    if (vulnerabilityDate == null) {
      missing.add('Vulnerability Check Date');
    }
    if (vulnerabilityDocumentPhoto == null && vulnerabilityDocumentFileName == null) {
      missing.add('Vulnerability Check Document');
    }
    if (registrationDocumentPhoto == null && registrationDocumentFileName == null) {
      missing.add('Vehicle Registration Photo');
    }

    if (missing.isNotEmpty) {
      AppSnackbar.error(
        title: 'Missing Required Documents',
        message: 'Please provide: ${missing.take(2).join(', ')}${missing.length > 2 ? ' and ${missing.length - 2} more item(s)' : ''}.',
      );
      return;
    }

    AppSnackbar.success(
      title: 'Registration Completed',
      message: 'Your vehicle insurance, registration and safety clearance were submitted for review!',
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
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
    insuranceProviderController.dispose();
    insuranceNumberController.dispose();
    vulnerabilityNumberController.dispose();
    super.onClose();
  }
}
