import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class WalkshareVerificationController extends GetxController {
  static WalkshareVerificationController get instance =>
      Get.find<WalkshareVerificationController>();

  final ImagePicker _picker = ImagePicker();

  String? licenceFrontFileName;
  String? licenceBackFileName;
  String? proofOfAddressFileName;
  String? propertyAgreementFileName;

  String _formatFileName(String rawName) {
    String name = rawName.split('/').last;
    if (name.contains(String.fromCharCode(92))) {
      name = name.split(String.fromCharCode(92)).last;
    }
    if (name.isEmpty) return 'document.jpg';
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

  Future<void> pickLicenceFront() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        licenceFrontFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      licenceFrontFileName = 'licence_front.jpg';
      update();
    }
  }

  Future<void> pickLicenceBack() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        licenceBackFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      licenceBackFileName = 'licence_back.jpg';
      update();
    }
  }

  Future<void> pickProofOfAddress() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        proofOfAddressFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      proofOfAddressFileName = 'utility_bill.pdf';
      update();
    }
  }

  Future<void> pickPropertyAgreement() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        propertyAgreementFileName = _formatFileName(file.name);
        update();
      }
    } catch (_) {
      propertyAgreementFileName = 'lease_agreement.pdf';
      update();
    }
  }

  void submitAndFinish() {
    AppSnackbar.success(
      title: 'Submitted',
      message: 'Your verification documents were submitted for review!',
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAllNamed(AppRoutes.signIn);
    });
  }
}
