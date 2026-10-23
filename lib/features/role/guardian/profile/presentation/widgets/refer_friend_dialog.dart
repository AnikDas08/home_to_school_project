import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ReferFriendDialog extends StatelessWidget {
  const ReferFriendDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ReferFriendDialog(),
    );
  }

  final String referralUrl = 'https://home2school.app/join?ref=parent_sadia_92';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Close "X" Button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ),

            /// Gift Icon
            Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFFBFDBFE),
                  width: 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.card_giftcard_rounded,
                size: 28.sp,
                color: const Color(0xFF2563EB),
              ),
            ),

            16.height,

            /// Title
            const CommonText(
              text: 'Invite Friends & Earn \$15',
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
              textAlign: TextAlign.center,
            ),

            8.height,

            /// Subtitle
            const CommonText(
              text:
                  'Get \$15 credit when an invited family completes their first commute.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
              textAlign: TextAlign.center,
            ),

            20.height,

            /// Referral Link Box
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.link_rounded,
                    size: 19.sp,
                    color: const Color(0xFF2563EB),
                  ),
                  8.width,
                  Expanded(
                    child: CommonText(
                      text: referralUrl,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0F172A),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  6.width,
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: referralUrl));
                      AppSnackbar.success(
                        title: 'Copied!',
                        message: 'Referral link copied to clipboard.',
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B68),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.copy_rounded,
                            size: 13.sp,
                            color: Colors.white,
                          ),
                          5.width,
                          const CommonText(
                            text: 'Copy',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            14.height,

            /// Done Button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 13.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: const CommonText(
                  text: 'Done',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),

            12.height,

            /// Footer Caption
            const CommonText(
              text: 'Credits apply automatically toward your next monthly pass.',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF94A3B8),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
