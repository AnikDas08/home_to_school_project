import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class BillingAndTransactionsScreen extends StatelessWidget {
  const BillingAndTransactionsScreen({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {
      'date': 'May 20, 2026 • 09:15 AM',
      'title': 'Weekly Commute (Round Trip)',
      'subtitle': 'Arman & Emma • Greenfield International',
      'amount': '\$120.00',
      'method': 'Stripe • Visa • • • • 4242',
      'status': 'Paid',
    },
    {
      'date': 'May 22, 2026 • 02:40 PM',
      'title': 'Weekly Commute (One Way)',
      'subtitle': 'Arman • Morning Commute',
      'amount': '\$65.00',
      'method': 'Stripe • Apple Pay',
      'status': 'Paid',
    },
    {
      'date': 'May 23, 2026 • 11:30 AM',
      'title': 'Single Day Pass (Round Trip)',
      'subtitle': 'Emma & Zara • Sunshine Pre-school',
      'amount': '\$55.00',
      'method': 'Stripe • Mastercard • • • • 8821',
      'status': 'Paid',
    },
    {
      'date': 'May 14, 2026 • 08:00 AM',
      'title': 'Weekly Commute (Round Trip)',
      'subtitle': 'Arman & Emma • Greenfield International',
      'amount': '\$120.00',
      'method': 'Stripe • Visa • • • • 4242',
      'status': 'Paid',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
        title: const CommonText(
          text: 'Billing & Transactions',
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

      /// Body
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Wallet Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2B68),
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x181B2B68),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CommonText(
                          text: 'PARENT WALLET CREDIT',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFCBD5E1),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 0.8,
                            ),
                          ),
                          child: const CommonText(
                            text: 'Active Balance',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    10.height,
                    const CommonText(
                      text: '\$45.00',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              24.height,

              /// Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    text: 'Recent Transactions',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  CommonText(
                    text: '${_transactions.length + 2} Transactions',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),

              14.height,

              /// Transactions List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _transactions.length,
                separatorBuilder: (_, __) => 12.height,
                itemBuilder: (context, index) {
                  final tx = _transactions[index];

                  return Container(
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
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Date & Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 13.sp,
                                  color: const Color(0xFF64748B),
                                ),
                                6.width,
                                CommonText(
                                  text: tx['date']!,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: const Color(0xFFA7F3D0),
                                  width: 0.8,
                                ),
                              ),
                              child: CommonText(
                                text: tx['status']!,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF059669),
                              ),
                            ),
                          ],
                        ),

                        10.height,

                        /// Title & Amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CommonText(
                                text: tx['title']!,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            10.width,
                            CommonText(
                              text: tx['amount']!,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ],
                        ),

                        4.height,

                        /// Commute Details
                        CommonText(
                          text: tx['subtitle']!,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                        ),

                        12.height,

                        const Divider(height: 1, color: Color(0xFFF1F5F9)),

                        10.height,

                        /// Method and Receipt Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card_outlined,
                                  size: 15.sp,
                                  color: const Color(0xFF64748B),
                                ),
                                6.width,
                                CommonText(
                                  text: tx['method']!,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF64748B),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                AppSnackbar.success(
                                  title: 'Receipt',
                                  message:
                                      'Downloading invoice for ${tx['title']}...',
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CommonText(
                                      text: 'Receipt',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1B2B68),
                                    ),
                                    3.width,
                                    Icon(
                                      Icons.north_east_rounded,
                                      size: 12.sp,
                                      color: const Color(0xFF1B2B68),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
