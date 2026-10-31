import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/driver/profile/data/models/driver_document_model.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class DriverDocumentsController extends GetxController {
  static DriverDocumentsController get instance =>
      Get.find<DriverDocumentsController>();

  final ImagePicker _picker = ImagePicker();
  DriverDocumentItem? selectedDocument;

  late List<DriverDocumentItem> documents;

  @override
  void onInit() {
    super.onInit();
    final driverName = LocalStorage.myName.isNotEmpty
        ? LocalStorage.myName
        : 'Robert MacDonald';

    documents = [
      DriverDocumentItem(
        id: 'licence',
        title: "Driver's Licence",
        icon: Icons.credit_card_outlined,
        status: 'Approved',
        documentNumber: 'DL-8492019-ON',
        issuedBy: 'Ministry of Transportation (Ontario)',
        issueDate: 'October 12, 2023',
        expiryDate: 'October 12, 2028',
        holderName: driverName,
        description:
            'Full Class G Ontario Driver\'s Licence valid for student passenger transport.',
      ),
      DriverDocumentItem(
        id: 'registration',
        title: 'Vehicle Registration',
        icon: Icons.directions_car_outlined,
        status: 'Approved',
        documentNumber: 'VR-2023-SCH4091',
        issuedBy: 'ServiceOntario Commercial & Passenger Registry',
        issueDate: 'January 10, 2024',
        expiryDate: 'January 10, 2027',
        holderName: driverName,
        description:
            'Official vehicle ownership and registration for 2023 Toyota Sienna (SCH-4091).',
      ),
      DriverDocumentItem(
        id: 'insurance',
        title: 'Vehicle Insurance',
        icon: Icons.shield_outlined,
        status: 'Approved',
        documentNumber: 'POL-992184-CA',
        issuedBy: 'Intact Commercial Student Rideshare Insurance',
        issueDate: 'November 01, 2024',
        expiryDate: 'November 01, 2026',
        holderName: driverName,
        description:
            '\$2,000,000 Commercial General & Passenger Liability insurance policy.',
      ),
      DriverDocumentItem(
        id: 'vulnerable_sector',
        title: 'Vulnerable Sector Check',
        icon: Icons.verified_user_outlined,
        status: 'Not Submitted',
        documentNumber: 'VSC-Pending',
        issuedBy: 'Toronto Police Service / OPP',
        issueDate: 'Not Issued',
        expiryDate: 'Required annually',
        holderName: driverName,
        description:
            'Mandatory criminal record and vulnerable sector background verification for transporting minors.',
      ),
      DriverDocumentItem(
        id: 'first_aid',
        title: 'First Aid & CPR',
        icon: Icons.health_and_safety_outlined,
        status: 'Not Submitted',
        documentNumber: 'CPR-Level-C',
        issuedBy: 'Canadian Red Cross / St. John Ambulance',
        issueDate: 'Not Issued',
        expiryDate: 'Valid for 3 years upon completion',
        holderName: driverName,
        description:
            'Standard First Aid & Infant/Child CPR Level C certification credential.',
      ),
    ];
  }

  int get approvedCount => documents.where((d) => d.isApproved).length;

  String get countText => '$approvedCount / ${documents.length} approved';

  void openDocumentDetails(DriverDocumentItem doc) {
    selectedDocument = doc;
    update();
    Get.toNamed(AppRoutes.documentDetails);
  }

  Future<void> uploadDocument(DriverDocumentItem doc, ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        doc.imagePath = file.path;
        doc.status = 'Approved';
        update();

        AppSnackbar.success(
          title: 'Document Uploaded',
          message: '${doc.title} has been uploaded and approved.',
        );
      }
    } catch (e) {
      AppSnackbar.error(
        title: 'Upload Failed',
        message: 'Could not upload document: $e',
      );
    }
  }
}
