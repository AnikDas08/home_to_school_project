import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  late final List<Map<String, dynamic>> _contacts;

  @override
  void initState() {
    super.initState();
    final isStudent = LocalStorage.role.toLowerCase().contains('student');
    if (isStudent) {
      _contacts = [
        {
          'name': 'Campus Security & SafeWalk',
          'isPrimary': true,
          'relationship': 'Campus Security',
          'phone': '+1 (416) 555-0199',
          'details': 'Campus Security • +1 (416) 555-0199',
        },
        {
          'name': 'Sarah Johnson',
          'isPrimary': false,
          'relationship': 'Mother',
          'phone': '+1 (416) 555-0144',
          'details': 'Mother • +1 (416) 555-0144',
        },
        {
          'name': 'Seneca Student Services Office',
          'isPrimary': false,
          'relationship': 'Campus Admin',
          'phone': '+1 (416) 555-0800',
          'details': 'Campus Admin • +1 (416) 555-0800',
        },
      ];
    } else {
      _contacts = [
        {
          'name': 'Farhan Khan',
          'isPrimary': true,
          'relationship': 'Father',
          'phone': '+1 (416) 555-0199',
          'details': 'Father • +1 (416) 555-0199',
        },
        {
          'name': 'Rehana Begum',
          'isPrimary': false,
          'relationship': 'Grandmother',
          'phone': '+1 (416) 555-0144',
          'details': 'Grandmother • +1 (416) 555-0144',
        },
        {
          'name': 'Greenfield School Main Office',
          'isPrimary': false,
          'relationship': 'School Admin',
          'phone': '+1 (416) 555-0800',
          'details': 'School Admin • +1 (416) 555-0800',
        },
      ];
    }
  }

  void _showContactDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final Map<String, dynamic>? existing =
        isEditing ? _contacts[editIndex] : null;

    final nameController =
        TextEditingController(text: existing?['name'] ?? '');
    final phoneController =
        TextEditingController(text: existing?['phone'] ?? '');

    String selectedRelationship = existing?['relationship'] ?? 'Parent';
    bool isPrimary = existing?['isPrimary'] == true;

    final isStudent = LocalStorage.role.toLowerCase().contains('student');
    final relationships = isStudent
        ? [
            'Parent',
            'Campus Security',
            'Campus Admin',
            'Sibling',
            'Roommate / Friend',
            'Doctor',
            'Other',
          ]
        : [
            'Father',
            'Mother',
            'Grandparent',
            'Legal Guardian',
            'School Admin',
            'Doctor',
            'Other',
          ];

    if (!relationships.contains(selectedRelationship)) {
      selectedRelationship = relationships.first;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header with Title and Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  isEditing
                                      ? Icons.edit_outlined
                                      : Icons.person_add_alt_1_rounded,
                                  size: 18.sp,
                                  color: const Color(0xFF1B2B68),
                                ),
                              ),
                              10.width,
                              CommonText(
                                text: isEditing
                                    ? 'Edit Contact'
                                    : 'Add Contact',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(ctx),
                            child: Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close_rounded,
                                size: 16.sp,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),

                      16.height,

                      /// Contact Name
                      const CommonText(
                        text: 'Full Name',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                      6.height,
                      _buildDialogTextField(
                        controller: nameController,
                        hint: 'e.g. David Miller / Campus Security',
                        icon: Icons.person_outline_rounded,
                      ),

                      14.height,

                      /// Relationship Dropdown
                      const CommonText(
                        text: 'Relationship / Role',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                      6.height,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedRelationship,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF64748B),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0F172A),
                            ),
                            items: relationships.map((rel) {
                              return DropdownMenuItem(
                                value: rel,
                                child: Text(rel),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setDialogState(
                                    () => selectedRelationship = val);
                              }
                            },
                          ),
                        ),
                      ),

                      14.height,

                      /// Phone Number
                      const CommonText(
                        text: 'Phone Number',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                      6.height,
                      _buildDialogTextField(
                        controller: phoneController,
                        hint: 'e.g. (416) 555-0199',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),

                      14.height,

                      /// Primary Contact Checkbox Tile
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isPrimary,
                              activeColor: const Color(0xFF1B2B68),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              onChanged: (val) {
                                setDialogState(() => isPrimary = val ?? false);
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CommonText(
                                    text: 'Set as Primary Contact',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A),
                                  ),
                                  2.height,
                                  const CommonText(
                                    text:
                                        'Notified first in case of an emergency',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF64748B),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      20.height,

                      /// Buttons (Cancel & Submit)
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(ctx),
                              child: Container(
                                height: 46.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                alignment: Alignment.center,
                                child: const CommonText(
                                  text: 'Cancel',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                          12.width,
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                final name = nameController.text.trim();
                                final phone = phoneController.text.trim();

                                if (name.isEmpty) {
                                  AppSnackbar.error(
                                    title: 'Required Field',
                                    message: 'Please enter contact full name.',
                                  );
                                  return;
                                }
                                if (phone.isEmpty) {
                                  AppSnackbar.error(
                                    title: 'Required Field',
                                    message:
                                        'Please enter contact phone number.',
                                  );
                                  return;
                                }

                                final formattedPhone = phone.startsWith('+')
                                    ? phone
                                    : (phone.startsWith('(')
                                        ? '+1 $phone'
                                        : '+1 (416) $phone');

                                final details =
                                    '$selectedRelationship • $formattedPhone';

                                setState(() {
                                  if (isPrimary) {
                                    for (var c in _contacts) {
                                      c['isPrimary'] = false;
                                    }
                                  }

                                  final contactData = {
                                    'name': name,
                                    'isPrimary': isPrimary,
                                    'relationship': selectedRelationship,
                                    'phone': formattedPhone,
                                    'details': details,
                                  };

                                  if (isEditing) {
                                    _contacts[editIndex] = contactData;
                                  } else {
                                    _contacts.add(contactData);
                                  }
                                });

                                Navigator.pop(ctx);
                                AppSnackbar.success(
                                  title: isEditing
                                      ? 'Contact Updated'
                                      : 'Contact Added',
                                  message: isEditing
                                      ? '$name details updated successfully.'
                                      : '$name added to emergency contacts.',
                                );
                              },
                              child: Container(
                                height: 46.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B2B68),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF1B2B68)
                                          .withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: CommonText(
                                  text: isEditing
                                      ? 'Save Changes'
                                      : 'Add Contact',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: const Color(0xFF64748B),
          ),
          10.width,
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
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
          text: 'Emergency Contacts',
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
        child: Column(
          children: [
            Expanded(
              child: _contacts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEFF6FF),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.contact_phone_outlined,
                              size: 28.sp,
                              color: const Color(0xFF1B2B68),
                            ),
                          ),
                          14.height,
                          const CommonText(
                            text: 'No Emergency Contacts',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                          6.height,
                          const CommonText(
                            text:
                                'Tap the button below to add your first emergency contact.',
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 16.h),
                      child: Container(
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
                          children: List.generate(_contacts.length, (index) {
                            final contact = _contacts[index];
                            final isLast = index == _contacts.length - 1;

                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /// Avatar
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(22.r),
                                        child: Image.asset(
                                          AppImages.profileImage,
                                          width: 44.w,
                                          height: 44.w,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              CircleAvatar(
                                            radius: 22.r,
                                            backgroundColor:
                                                const Color(0xFFEFF6FF),
                                            child: Icon(
                                              Icons.person,
                                              size: 24.sp,
                                              color: const Color(0xFF1B2B68),
                                            ),
                                          ),
                                        ),
                                      ),

                                      12.width,

                                      /// Contact Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: CommonText(
                                                    text: contact['name']!,
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        const Color(0xFF0F172A),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                if (contact['isPrimary'] ==
                                                    true) ...[
                                                  6.width,
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 7.w,
                                                      vertical: 2.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFEFF6FF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFFBFDBFE),
                                                        width: 0.8,
                                                      ),
                                                    ),
                                                    child: const CommonText(
                                                      text: 'Primary',
                                                      fontSize: 10.5,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xFF2563EB),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                            3.height,
                                            CommonText(
                                              text: contact['details']!,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// 3 Dots Dropdown Menu
                                      PopupMenuButton<String>(
                                        icon: const Icon(
                                          Icons.more_vert_rounded,
                                          color: Color(0xFF94A3B8),
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        color: Colors.white,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          side: const BorderSide(
                                            color: Color(0xFFF1F5F9),
                                            width: 1,
                                          ),
                                        ),
                                        offset: const Offset(0, 36),
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            _showContactDialog(
                                                editIndex: index);
                                          } else if (value == 'delete') {
                                            final name = contact['name'];
                                            setState(() {
                                              _contacts.removeAt(index);
                                            });
                                            AppSnackbar.success(
                                              title: 'Deleted',
                                              message: '$name removed',
                                            );
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem<String>(
                                            value: 'edit',
                                            height: 38.h,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit_outlined,
                                                  size: 18.sp,
                                                  color:
                                                      const Color(0xFF0F172A),
                                                ),
                                                10.width,
                                                const CommonText(
                                                  text: 'Edit',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF0F172A),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuDivider(height: 1),
                                          PopupMenuItem<String>(
                                            value: 'delete',
                                            height: 38.h,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete_outline_rounded,
                                                  size: 18.sp,
                                                  color:
                                                      const Color(0xFFEF4444),
                                                ),
                                                10.width,
                                                const CommonText(
                                                  text: 'Delete',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFEF4444),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                    ),
            ),

            /// Add Contact Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: GestureDetector(
                onTap: () => _showContactDialog(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2B68),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B2B68).withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                      8.width,
                      const CommonText(
                        text: 'Add Contact',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
