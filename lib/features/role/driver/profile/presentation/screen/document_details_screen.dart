import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/profile/data/models/driver_document_model.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/controller/driver_documents_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DocumentDetailsScreen extends StatelessWidget {
  const DocumentDetailsScreen({super.key});

  void _showUploadBottomSheet(
      BuildContext context, DriverDocumentsController controller, DriverDocumentItem doc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                CommonText(
                  text: 'Upload ${doc.title}',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                4.height,
                const CommonText(
                  text: 'Select a clear photo or scan of your document',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
                18.height,
                _buildSourceTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select from photo library',
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.uploadDocument(doc, ImageSource.gallery);
                  },
                ),
                10.height,
                _buildSourceTile(
                  icon: Icons.camera_alt_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                  title: 'Take a Photo',
                  subtitle: 'Use camera to capture document',
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.uploadDocument(doc, ImageSource.camera);
                  },
                ),
                16.height,
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    alignment: Alignment.center,
                    child: const CommonText(
                      text: 'Cancel',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSourceTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9.r),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  2.height,
                  CommonText(
                    text: subtitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverDocumentsController>();

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: Color(0xFF0F172A),
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: GetBuilder<DriverDocumentsController>(
          builder: (_) => CommonText(
            text: controller.selectedDocument?.title ?? 'Document Details',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),

      /// Body Details
      body: SafeArea(
        child: GetBuilder<DriverDocumentsController>(
          builder: (_) {
            final doc = controller.selectedDocument;
            if (doc == null) {
              return const Center(child: Text('No document selected'));
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. Status Hero Banner Card
                  _buildStatusHeroCard(doc),

                  16.height,

                  /// 2. Document Information Card
                  _buildDetailsCard(doc),

                  16.height,

                  /// 3. Document Copy Preview / Upload Box
                  _buildDocumentPreviewCard(context, controller, doc),

                  24.height,

                  /// 4. Action Button
                  if (doc.isNotSubmitted)
                    GestureDetector(
                      onTap: () => _showUploadBottomSheet(context, controller, doc),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B2B68),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x201B2B68),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const CommonText(
                          text: 'Upload Document',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () => _showUploadBottomSheet(context, controller, doc),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFF1B2B68),
                            width: 1.2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const CommonText(
                          text: 'Update or Re-upload Document',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B2B68),
                        ),
                      ),
                    ),

                  20.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// 1. Status Hero Card
  Widget _buildStatusHeroCard(DriverDocumentItem doc) {
    Color cardBg;
    Color iconBg;
    Color iconColor;
    IconData iconData;
    String statusTitle;
    String statusSubtitle;

    if (doc.isApproved) {
      cardBg = const Color(0xFFF0FDF4); // Soft green
      iconBg = const Color(0xFFDCFCE7);
      iconColor = const Color(0xFF16A34A);
      iconData = Icons.verified_rounded;
      statusTitle = 'Approved & Verified';
      statusSubtitle =
          'This document has been verified by the Home2School safety team.';
    } else if (doc.isNotSubmitted) {
      cardBg = const Color(0xFFF8FAFC); // Slate
      iconBg = const Color(0xFFE2E8F0);
      iconColor = const Color(0xFF64748B);
      iconData = Icons.file_upload_outlined;
      statusTitle = 'Not Submitted';
      statusSubtitle =
          'Upload this document to complete your driver verification profile.';
    } else {
      cardBg = const Color(0xFFFFFBEB); // Amber
      iconBg = const Color(0xFFFEF3C7);
      iconColor = const Color(0xFFD97706);
      iconData = Icons.hourglass_top_rounded;
      statusTitle = 'Under Review';
      statusSubtitle =
          'Your document is currently being reviewed by our verification team.';
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: doc.isApproved
              ? const Color(0xFFBBF7D0)
              : const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 24.sp),
          ),
          14.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: statusTitle,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                3.height,
                CommonText(
                  text: statusSubtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 2. Document Information Card
  Widget _buildDetailsCard(DriverDocumentItem doc) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: 'Document Information',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          12.height,
          _buildInfoRow('Document Name', doc.title),
          _buildInfoRow('Document ID / Number', doc.documentNumber),
          _buildInfoRow('Holder Name', doc.holderName),
          _buildInfoRow('Issuing Authority', doc.issuedBy),
          _buildInfoRow('Issue Date', doc.issueDate),
          _buildInfoRow('Expiry Date', doc.expiryDate),
          _buildInfoRow('Verification Status', doc.status,
              isHighlight: doc.isApproved),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CommonText(
              text: label,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
          8.width,
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
                color: isHighlight
                    ? const Color(0xFF16A34A)
                    : const Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 3. Document Preview / Upload Container
  Widget _buildDocumentPreviewCard(
      BuildContext context, DriverDocumentsController controller, DriverDocumentItem doc) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: CommonText(
                  text: 'Document Copy',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              if (doc.isApproved)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const CommonText(
                    text: 'Verified Official Copy',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B2B68),
                  ),
                ),
            ],
          ),
          12.height,
          if (doc.imagePath != null && File(doc.imagePath!).existsSync())
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(
                File(doc.imagePath!),
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            )
          else if (doc.isApproved)
            Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 38.sp,
                    color: const Color(0xFF1B2B68),
                  ),
                  8.height,
                  const CommonText(
                    text: 'Digital Document on File',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  2.height,
                  const CommonText(
                    text: 'Encrypted & Stored Securely',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () => _showUploadBottomSheet(context, controller, doc),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF93C5FD),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 32.sp,
                      color: const Color(0xFF1B2B68),
                    ),
                    8.height,
                    const CommonText(
                      text: 'Tap to upload or take a photo',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                    2.height,
                    const CommonText(
                      text: 'Supports JPG, PNG, and PDF files',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
