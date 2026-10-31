import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/controller/walkshare_documents_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareDocumentsScreen extends StatelessWidget {
  const WalkshareDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareDocumentsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      /// App Bar: "Documents" matching Screenshot
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

      /// Body Content: Document Cards
      body: SafeArea(
        child: GetBuilder<WalkshareDocumentsController>(
          builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      children: [
                        /// Read-only / Locked notice
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 14.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 10.h),
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

                        ...List.generate(controller.documents.length, (index) {
                          final doc = controller.documents[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 14.h),
                            child: _buildDocumentCard(context, controller, doc),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                /// Bottom "Done" Button
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
                  child: GestureDetector(
                    onTap: controller.onDone,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B68),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1B2B68).withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const CommonText(
                        text: 'Done',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Single Document Card
  Widget _buildDocumentCard(
    BuildContext context,
    WalkshareDocumentsController controller,
    WalkshareDocumentModel doc,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  doc.icon,
                  size: 20.sp,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: doc.title,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    3.height,
                    CommonText(
                      text: doc.subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CommonText(
                  text: doc.status,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),

          14.height,

          /// Document Preview Boxes
          if (doc.isTwoSided)
            Row(
              children: [
                Expanded(
                  child: _buildPreviewBox(
                    context: context,
                    label: 'Front',
                    file: doc.frontFile,
                  ),
                ),
                12.width,
                Expanded(
                  child: _buildPreviewBox(
                    context: context,
                    label: 'Back',
                    file: doc.backFile,
                  ),
                ),
              ],
            )
          else
            _buildWidePreviewBox(
              context: context,
              label: 'Document on File',
              file: doc.frontFile,
            ),
        ],
      ),
    );
  }

  /// Two-sided half-width preview box (Driving Licence) - Read-only
  Widget _buildPreviewBox({
    required BuildContext context,
    required String label,
    File? file,
  }) {
    return Container(
      height: 94.h,
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Stack(
        children: [
          /// Real photo or stylized logo in center
          if (file != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.file(
                file,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  4.width,
                  Transform.rotate(
                    angle: 0.3,
                    child: Container(
                      width: 16.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          /// Bottom-left locked badge: [ 🔒 Front / Back ]
          Positioned(
            left: 8.w,
            bottom: 8.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 11.sp,
                    color: Colors.white,
                  ),
                  4.width,
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Full-width wide preview box (Proof of address / Utility bill) - Read-only
  Widget _buildWidePreviewBox({
    required BuildContext context,
    required String label,
    File? file,
  }) {
    return Container(
      height: 72.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Stack(
        children: [
          /// Real photo or stylized logo in center
          if (file != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.file(
                file,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  4.width,
                  Transform.rotate(
                    angle: 0.3,
                    child: Container(
                      width: 18.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          /// Bottom-left locked badge: [ 🔒 Document on File ]
          Positioned(
            left: 10.w,
            bottom: 8.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 12.sp,
                    color: Colors.white,
                  ),
                  5.width,
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
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
