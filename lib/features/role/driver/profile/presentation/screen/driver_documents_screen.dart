import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/profile/data/models/driver_document_model.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/controller/driver_documents_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverDocumentsScreen extends StatelessWidget {
  const DriverDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverDocumentsController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar matching design: "Documents"
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
        title: const CommonText(
          text: 'Documents',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
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

      /// Body Content
      body: SafeArea(
        child: GetBuilder<DriverDocumentsController>(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Subtitle: "3 / 5 approved"
                  CommonText(
                    text: controller.countText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),

                  12.height,

                  /// Read-only / Locked notice
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 16.sp,
                          color: const Color(0xFF64748B),
                        ),
                        8.width,
                        Expanded(
                          child: Text(
                            'Submitted documents are locked for safety & verification compliance.',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              color: const Color(0xFF475569),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  12.height,

                  /// Documents Card
                  Container(
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
                      children: List.generate(
                        controller.documents.length,
                        (index) {
                          final doc = controller.documents[index];
                          final isLast =
                              index == controller.documents.length - 1;
                          return _buildDocumentRow(
                            controller: controller,
                            doc: doc,
                            showDivider: !isLast,
                          );
                        },
                      ),
                    ),
                  ),

                  30.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDocumentRow({
    required DriverDocumentsController controller,
    required DriverDocumentItem doc,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.openDocumentDetails(doc),
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              child: Row(
                children: [
                  /// Left Document Outline Icon (Deep Navy #1B2B68)
                  Icon(
                    doc.icon,
                    size: 22.sp,
                    color: const Color(0xFF1B2B68),
                  ),

                  14.width,

                  /// Document Title
                  Expanded(
                    child: Text(
                      doc.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  8.width,

                  /// Status Badge Pill
                  _buildStatusBadge(doc.status),

                  6.width,

                  /// Trailing Chevron
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: Color(0xFF94A3B8),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'approved':
        bgColor = const Color(0xFFEFF6FF); // Soft light blue pill
        textColor = const Color(0xFF1B2B68); // Brand dark navy
        break;
      case 'not submitted':
        bgColor = const Color(0xFFF1F5F9); // Light slate grey pill
        textColor = const Color(0xFF64748B); // Slate text
        break;
      case 'pending review':
      default:
        bgColor = const Color(0xFFFEF3C7); // Soft amber
        textColor = const Color(0xFFD97706);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 4.5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11.5.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
