import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final _searchController = TextEditingController();
  final Set<int> _expandedIndices = {0}; // First question expanded by default

  final List<Map<String, String>> _allFaqs = [
    {
      'question': 'How are drivers background-checked and vetted?',
      'answer':
          'Every Home2School driver passes a multi-tier vulnerable sector criminal record check, clean driving abstract verification, annual vehicle inspection, and in-person orientation before accepting student rides.',
    },
    {
      'question': 'Can parents track child rides with live GPS?',
      'answer':
          'Yes, parents can track their child\'s ride in real-time with continuous live GPS updates, route checkpoints, and instant notifications when student is picked up or dropped off.',
    },
    {
      'question':
          'Can I book for multiple children attending different schools?',
      'answer':
          'Yes, you can register each of your children, add their respective schools, and easily schedule coordinated morning drop-offs and afternoon pickups.',
    },
    {
      'question': 'What happens if a driver is delayed in morning traffic?',
      'answer':
          'Our intelligent dispatch system monitors traffic conditions and automatically sends push alerts to parents if a delay is expected, providing estimated delay times.',
    },
    {
      'question': 'How are multi-child sibling discounts applied?',
      'answer':
          'Multi-child discounts are automatically calculated and applied at checkout when you schedule passes for two or more children in the same family.',
    },
  ];

  List<Map<String, String>> _filteredFaqs = [];

  @override
  void initState() {
    super.initState();
    _filteredFaqs = List.from(_allFaqs);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredFaqs = List.from(_allFaqs);
      } else {
        _filteredFaqs = _allFaqs
            .where((faq) =>
                faq['question']!.toLowerCase().contains(query) ||
                faq['answer']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

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
          text: 'Help & FAQ',
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              /// Search Field
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 20.sp,
                      color: const Color(0xFF94A3B8),
                    ),
                    10.width,
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          color: const Color(0xFF0F172A),
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search questions or safety policies...',
                          hintStyle: TextStyle(
                            fontSize: 13.5.sp,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              18.height,

              /// FAQ Accordion Card
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
                  children: List.generate(_filteredFaqs.length, (index) {
                    final faq = _filteredFaqs[index];
                    final isExpanded = _expandedIndices.contains(index);
                    final isLast = index == _filteredFaqs.length - 1;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () => _toggleExpand(index),
                          borderRadius: BorderRadius.vertical(
                            top: index == 0 ? Radius.circular(16.r) : Radius.zero,
                            bottom: isLast && !isExpanded
                                ? Radius.circular(16.r)
                                : Radius.zero,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 16.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CommonText(
                                        text: faq['question']!,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w600,
                                        color: isExpanded
                                            ? const Color(0xFF1B2B68)
                                            : const Color(0xFF0F172A),
                                        textAlign: TextAlign.start,
                                        maxLines: 4,
                                      ),
                                    ),
                                    10.width,
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.keyboard_arrow_down_rounded,
                                      size: 22.sp,
                                      color: isExpanded
                                          ? const Color(0xFF1B2B68)
                                          : const Color(0xFF64748B),
                                    ),
                                  ],
                                ),
                                if (isExpanded) ...[
                                  12.height,
                                  CommonText(
                                    text: faq['answer']!,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF64748B),
                                    textAlign: TextAlign.start,
                                    maxLines: 4,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        if (!isLast)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF1F5F9),
                          ),
                      ],
                    );
                  }),
                ),
              ),

              20.height,

              /// Didn't find your answer? Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F7FF),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: const Color(0xFFDCEBFE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    /// Headset Icon
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.headset_mic_outlined,
                        size: 22.sp,
                        color: const Color(0xFF1B2B68),
                      ),
                    ),

                    12.height,

                    /// Heading
                    const CommonText(
                      text: "Didn't find your answer?",
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                      textAlign: TextAlign.center,
                    ),

                    6.height,

                    /// Subtext
                    const CommonText(
                      text:
                          'Our support team is available 24/7 to assist with custom routes, pricing, or driver questions.',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                      textAlign: TextAlign.center,
                    ),

                    18.height,

                    /// Two Action Buttons
                    Row(
                      children: [
                        /// Button 1: Contact Support
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                Get.toNamed(AppRoutes.contactSupport),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B2B68),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                  6.width,
                                  const CommonText(
                                    text: 'Contact Support',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        10.width,

                        /// Button 2: Call Helpline
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              AppSnackbar.success(
                                title: 'Helpline',
                                message:
                                    'Connecting you to support: +1 (800) 555-4663',
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_outlined,
                                    size: 15.sp,
                                    color: const Color(0xFF1B2B68),
                                  ),
                                  6.width,
                                  const CommonText(
                                    text: 'Call Helpline',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1B2B68),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
