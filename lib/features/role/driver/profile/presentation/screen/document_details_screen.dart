import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/driver/profile/data/models/driver_document_model.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/controller/driver_documents_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DocumentDetailsScreen extends StatelessWidget {
  const DocumentDetailsScreen({super.key});

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

                  /// 4. Read-Only Compliance Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 18.sp,
                          color: const Color(0xFF64748B),
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Document is locked',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              3.height,
                              Text(
                                'Documents cannot be edited after registration for safety and verification compliance. Contact support to request any update.',
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF64748B),
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  14.height,

                  /// 5. Contact Support Button
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.contactSupport),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.headset_mic_outlined,
                            size: 18.sp,
                            color: const Color(0xFF1B2B68),
                          ),
                          8.width,
                          const CommonText(
                            text: 'Contact Support to Update',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B2B68),
                          ),
                        ],
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
                  CommonText(
                    text: doc.isApproved
                        ? 'Digital Document on File'
                        : 'Document Submitted',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                  2.height,
                  const CommonText(
                    text: 'Encrypted & Stored Securely (Read-only)',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
