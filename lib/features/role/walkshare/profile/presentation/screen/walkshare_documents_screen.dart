import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/controller/walkshare_documents_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareDocumentsScreen extends StatelessWidget {
  const WalkshareDocumentsScreen({super.key});

  void _showUploadSourceDialog(
    BuildContext context,
    WalkshareDocumentsController controller,
    WalkshareDocumentModel doc, {
    required bool isBack,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                CommonText(
                  text: 'Upload ${doc.title} ${isBack ? "(Back)" : "(Front)"}',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                16.height,
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: Color(0xFF1B2B68),
                    ),
                  ),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.pickPhoto(doc,
                        isBack: isBack, source: ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFECFDF5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF059669),
                    ),
                  ),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    Navigator.pop(ctx);
                    controller.pickPhoto(doc,
                        isBack: isBack, source: ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                      children: List.generate(controller.documents.length,
                          (index) {
                        final doc = controller.documents[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: _buildDocumentCard(context, controller, doc),
                        );
                      }),
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
                            color: const Color(0xFF1B2B68).withOpacity(0.25),
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
            color: Colors.black.withOpacity(0.02),
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
                    onTap: () => _showUploadSourceDialog(
                      context,
                      controller,
                      doc,
                      isBack: false,
                    ),
                  ),
                ),
                12.width,
                Expanded(
                  child: _buildPreviewBox(
                    context: context,
                    label: 'Back',
                    file: doc.backFile,
                    onTap: () => _showUploadSourceDialog(
                      context,
                      controller,
                      doc,
                      isBack: true,
                    ),
                  ),
                ),
              ],
            )
          else
            _buildWidePreviewBox(
              context: context,
              label: 'Replace',
              file: doc.frontFile,
              onTap: () => _showUploadSourceDialog(
                context,
                controller,
                doc,
                isBack: false,
              ),
            ),
        ],
      ),
    );
  }

  /// Two-sided half-width preview box (Driving Licence)
  Widget _buildPreviewBox({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
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

          /// Bottom-left button: [ ↻ Front / Back ]
          Positioned(
            left: 8.w,
            bottom: 8.h,
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      size: 13.sp,
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
          ),
        ],
      ),
    );
  }

  /// Full-width wide preview box (Proof of address / Utility bill)
  Widget _buildWidePreviewBox({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
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

          /// Bottom-left button: [ ↻ Replace ]
          Positioned(
            left: 10.w,
            bottom: 8.h,
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      size: 13.sp,
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
          ),
        ],
      ),
    );
  }
}
