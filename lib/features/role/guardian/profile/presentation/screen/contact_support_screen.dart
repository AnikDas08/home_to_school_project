import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final _messageController = TextEditingController();
  String _selectedTopic = 'Select Topic';

  final List<String> _topics = [
    'Booking & Rides',
    'Safety & Concerns',
    'Payment & Billing',
    'Driver Feedback',
    'Account & Profile',
    'Other Inquiries',
  ];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showTopicPicker() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                16.height,
                const CommonText(
                  text: 'Select Support Topic',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                12.height,
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                ..._topics.map((topic) {
                  final isSelected = _selectedTopic == topic;
                  return ListTile(
                    title: CommonText(
                      text: topic,
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                      color: isSelected
                          ? const Color(0xFF1B2B68)
                          : const Color(0xFF0F172A),
                      textAlign: TextAlign.start,
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Color(0xFF1B2B68),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedTopic = topic;
                      });
                      Navigator.pop(ctx);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _sendMessage() {
    if (_selectedTopic == 'Select Topic') {
      AppSnackbar.error(
        title: 'Topic Required',
        message: 'Please choose a support topic',
      );
      return;
    }

    if (_messageController.text.trim().isEmpty) {
      AppSnackbar.error(
        title: 'Message Required',
        message: 'Please describe your question or issue',
      );
      return;
    }

    Get.back();
    AppSnackbar.success(
      title: 'Message Sent',
      message: 'We typically reply within a few minutes. Check your email.',
    );
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
          text: 'Contact Support',
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// How can we help?
                const CommonText(
                  text: 'How can we help?',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),

                6.height,

                /// Subtitle
                const CommonText(
                  text: 'We typically reply within a few minutes.',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),

                24.height,

                /// Select Topic Label
                const CommonText(
                  text: 'Select Topic',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),

                8.height,

                /// Topic Dropdown Field
                GestureDetector(
                  onTap: _showTopicPicker,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: _selectedTopic,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _selectedTopic == 'Select Topic'
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF0F172A),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 22.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ),
                ),

                20.height,

                /// Your Message Label with Counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonText(
                      text: 'Your Message',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                    CommonText(
                      text: '${_messageController.text.length} / 500',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF94A3B8),
                    ),
                  ],
                ),

                8.height,

                /// Message Multiline Input
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    maxLines: 6,
                    maxLength: 500,
                    buildCounter: (_,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        null,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF0F172A),
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your question or request here...',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(14.w),
                    ),
                  ),
                ),

                28.height,

                /// Send Message Button
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2B68),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A1B2B68),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: -0.4,
                          child: Icon(
                            Icons.send_rounded,
                            size: 17.sp,
                            color: Colors.white,
                          ),
                        ),
                        8.width,
                        const CommonText(
                          text: 'Send Message',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
