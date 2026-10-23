import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_to_school/component/button/common_button.dart';
import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ParentConsentDialog extends StatelessWidget {
  final VoidCallback? onConsent;

  const ParentConsentDialog({super.key, this.onConsent});

  static Future<void> show(BuildContext context, {VoidCallback? onConsent}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (context) => SafeArea(
        child: ParentConsentDialog(onConsent: onConsent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Header Row: Icon + Titles + Close Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Shield Icon Container
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.verified_user_outlined,
                      size: 22.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  12.width,

                  /// Title & Subtitle Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: 'Parent Consent Form',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.titleColor,
                          textAlign: TextAlign.start,
                        ),
                        2.height,
                        const CommonText(
                          text: 'PIPEDA Compliance & Child Safety',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtitleColor,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  /// Close Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),

              14.height,

              /// Top Divider
              const Divider(
                color: Color(0xFFF1F5F9),
                height: 1,
                thickness: 1,
              ),

              14.height,

              /// Paragraph 1
              _buildConsentItem(
                heading: '1. Scope of Consent: ',
                body:
                    'As the lawful guardian, you give explicit consent to Home2School Inc. to process child profile details (name, grade level, school location) strictly for organizing verified school commutes.',
              ),

              12.height,

              /// Paragraph 2
              _buildConsentItem(
                heading: '2. Live GPS Tracking (Privacy by Design): ',
                body:
                    'Real-time satellite GPS tracking activates exclusively when a trip is marked active and in-progress by your assigned provider. No background location is collected when trips are completed.',
              ),

              12.height,

              /// Paragraph 3
              _buildConsentItem(
                heading: '3. Masked Communication: ',
                body:
                    'Contact details (phone number, email address) are masked between parents and providers to prevent unauthorized external contact.',
              ),

              12.height,

              /// Paragraph 4
              _buildConsentItem(
                heading: '4. Right to Erasure (PIPEDA): ',
                body:
                    'You retain full authority to request permanent deletion of your profile, child information, and historical GPS transit records at any time via Profile Settings.',
              ),

              16.height,

              /// Bottom Divider
              const Divider(
                color: Color(0xFFF1F5F9),
                height: 1,
                thickness: 1,
              ),

              18.height,

              /// "I Understand & Consent" Action Button
              CommonButton(
                titleText: 'I Understand & Consent',
                onTap: () {
                  Get.back();
                  if (onConsent != null) {
                    onConsent!();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsentItem({
    required String heading,
    required String body,
  }) {
    return Text.rich(
      TextSpan(
        text: heading,
        style: GoogleFonts.roboto(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          height: 1.45,
        ),
        children: [
          TextSpan(
            text: body,
            style: GoogleFonts.roboto(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
