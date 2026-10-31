import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_to_school/features/role/walkshare/presentation/controller/walkshare_verification_controller.dart';

class WalkshareDocumentModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isTwoSided;
  String status; // 'In review', 'Approved', 'Pending'
  File? frontFile;
  File? backFile;

  WalkshareDocumentModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isTwoSided = false,
    this.status = 'In review',
    this.frontFile,
    this.backFile,
  });
}

class WalkshareDocumentsController extends GetxController {
  static WalkshareDocumentsController get instance =>
      Get.find<WalkshareDocumentsController>();

  final ImagePicker _picker = ImagePicker();

  late final List<WalkshareDocumentModel> documents;

  @override
  void onInit() {
    super.onInit();
    _initializeDocuments();
  }

  void _initializeDocuments() {
    WalkshareVerificationController? verificationCtrl;
    if (Get.isRegistered<WalkshareVerificationController>()) {
      verificationCtrl = WalkshareVerificationController.instance;
    }

    documents = [
      WalkshareDocumentModel(
        id: '1',
        title: 'Driving licence',
        subtitle: 'Both sides',
        icon: Icons.credit_card_outlined,
        isTwoSided: true,
        status: 'In review',
        frontFile: verificationCtrl?.licenceFrontPhoto,
        backFile: verificationCtrl?.licenceBackPhoto,
      ),
      WalkshareDocumentModel(
        id: '2',
        title: 'Proof of address',
        subtitle: 'Current Utility Bill',
        icon: Icons.home_outlined,
        isTwoSided: false,
        status: 'In review',
        frontFile: verificationCtrl?.proofOfAddressPhoto,
      ),
      WalkshareDocumentModel(
        id: '3',
        title: 'Property tax or tenant agreement',
        subtitle: 'Latest information',
        icon: Icons.receipt_long_outlined,
        isTwoSided: false,
        status: 'In review',
        frontFile: verificationCtrl?.propertyAgreementPhoto,
      ),
    ];
  }

  Future<void> pickPhoto(WalkshareDocumentModel doc, {required bool isBack, required ImageSource source}) async {
    try {
      final XFile? picked = await _picker.pickImage(source: source, imageQuality: 85);
      if (picked != null) {
        if (isBack) {
          doc.backFile = File(picked.path);
        } else {
          doc.frontFile = File(picked.path);
        }
        update();
        Get.snackbar(
          'Document Uploaded',
          '${doc.title} has been updated.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF1B2B68),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      debugPrint('Error picking document photo: $e');
    }
  }

  void onDone() {
    Get.back();
  }
}
