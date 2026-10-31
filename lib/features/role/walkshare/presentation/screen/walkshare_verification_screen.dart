import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/walkshare/presentation/controller/walkshare_verification_controller.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareVerificationScreen extends StatelessWidget {
  const WalkshareVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalkshareVerificationController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar with Clean Back Button
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
        child: GetBuilder<WalkshareVerificationController>(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 1. Page Header (Centered)
                  const CommonText(
                    text: 'Verify your identity',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  6.height,
                  const CommonText(
                    text: 'Clear photos. We review them within 24 hours.',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),

                  20.height,

                  /// 2. Card 1: Driving Licence (Front & Back)
                  _buildCardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCardHeader(
                          icon: Icons.credit_card_outlined,
                          title: 'Driving licence',
                          subtitle: 'Both sides',
                        ),
                        14.height,
                        Row(
                          children: [
                            /// Front Box
                            Expanded(
                              child: _buildLicenceSideBox(
                                label: 'Front',
                                isPicked: controller.licenceFrontFileName != null,
                                fileName: controller.licenceFrontFileName,
                                onTap: controller.pickLicenceFront,
                              ),
                            ),
                            12.width,
                            /// Back Box
                            Expanded(
                              child: _buildLicenceSideBox(
                                label: 'Back',
                                isPicked: controller.licenceBackFileName != null,
                                fileName: controller.licenceBackFileName,
                                onTap: controller.pickLicenceBack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// 3. Card 2: Proof of Address
                  _buildCardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCardHeader(
                          icon: Icons.home_outlined,
                          title: 'Proof of address',
                          subtitle: 'Current Utility Bill',
                        ),
                        14.height,
                        _buildDocumentUploadBox(
                          fileName: controller.proofOfAddressFileName,
                          onTap: controller.pickProofOfAddress,
                        ),
                      ],
                    ),
                  ),

                  16.height,

                  /// 4. Card 3: Property Tax or Tenant Agreement
                  _buildCardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCardHeader(
                          icon: Icons.receipt_long_outlined,
                          title: 'Property tax or tenant agreement',
                          subtitle: 'Latest information',
                        ),
                        14.height,
                        _buildDocumentUploadBox(
                          fileName: controller.propertyAgreementFileName,
                          onTap: controller.pickPropertyAgreement,
                        ),
                      ],
                    ),
                  ),

                  28.height,

                  /// 5. Submit & Finish Button
                  GestureDetector(
                    onTap: controller.submitAndFinish,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B68),
                        borderRadius: BorderRadius.circular(12.r),
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
                        text: 'Submit & finish',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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

  /// White card wrapper with clean border and padding
  Widget _buildCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: child,
    );
  }

  /// Top row of each card with icon container, title, and subtitle
  Widget _buildCardHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 20.sp,
            color: const Color(0xFF1B2B68),
          ),
        ),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              2.height,
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Square-ish upload box for Licence Front / Back with camera icon
  Widget _buildLicenceSideBox({
    required String label,
    required bool isPicked,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 84.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isPicked
                  ? const Color(0xFF93C5FD)
                  : const Color(0xFFE2E8F0),
              width: isPicked ? 1.2 : 1.0,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPicked ? Icons.check_circle_rounded : Icons.camera_alt_outlined,
                size: 22.sp,
                color: isPicked ? const Color(0xFF10B981) : const Color(0xFF1B2B68),
              ),
              6.height,
              Text(
                isPicked && fileName != null ? fileName : label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1B2B68),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Full-width document upload box for utility bill & tenant agreement
  Widget _buildDocumentUploadBox({
    required String? fileName,
    required VoidCallback onTap,
  }) {
    final bool isPicked = fileName != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          constraints: BoxConstraints(minHeight: 64.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isPicked
                  ? const Color(0xFF93C5FD)
                  : const Color(0xFFE2E8F0),
              width: isPicked ? 1.2 : 1.0,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: isPicked
                      ? const Color(0xFFEFF6FF)
                      : const Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  isPicked ? Icons.check_rounded : Icons.cloud_upload_outlined,
                  size: 20.sp,
                  color: isPicked ? const Color(0xFF10B981) : const Color(0xFF1B2B68),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fileName ?? 'Upload Document File',
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    3.height,
                    Text(
                      'JPG, PNG or PDF (Max 10MB)',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              if (isPicked) ...[
                8.width,
                Icon(
                  Icons.check_circle_rounded,
                  size: 20.sp,
                  color: const Color(0xFF10B981),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
