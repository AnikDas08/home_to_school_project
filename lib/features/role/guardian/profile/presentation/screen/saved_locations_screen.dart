import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  final List<Map<String, dynamic>> _locations = [
    {
      'name': 'Home',
      'address': '12 Elm Street, Toronto, ON',
      'isDefault': true,
      'isHome': true,
    },
    {
      'name': 'Greenfield International School',
      'address': 'Gate 2 Drop-off Loop, Toronto, ON',
      'isDefault': false,
      'isHome': false,
    },
    {
      'name': 'Sunshine Pre-school',
      'address': '45 Bloom Avenue, Toronto, ON',
      'isDefault': false,
      'isHome': false,
    },
    {
      'name': "Grandmother's House",
      'address': '84 Willowbrook Crescent, Toronto, ON',
      'isDefault': false,
      'isHome': false,
    },
  ];

  void _showAddAddressDialog() {
    final nameCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const CommonText(
          text: 'Add New Address',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Location Name',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            6.height,
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                hintText: 'e.g. Daycare, School, Office',
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
            12.height,
            const CommonText(
              text: 'Address',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            6.height,
            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                hintText: 'Full street address',
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CommonText(
              text: 'Cancel',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B2B68),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              final name = nameCtrl.text.trim();
              final addr = addressCtrl.text.trim();
              if (name.isEmpty || addr.isEmpty) return;

              setState(() {
                _locations.add({
                  'name': name,
                  'address': addr,
                  'isDefault': false,
                  'isHome': name.toLowerCase().contains('home'),
                });
              });
              Navigator.pop(ctx);
              AppSnackbar.success(
                title: 'Success',
                message: '$name added to saved locations',
              );
            },
            child: const CommonText(
              text: 'Add Address',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditAddressDialog(int index) {
    final item = _locations[index];
    final nameCtrl = TextEditingController(text: item['name']);
    final addressCtrl = TextEditingController(text: item['address']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const CommonText(
          text: 'Edit Location',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Location Name',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            6.height,
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
            12.height,
            const CommonText(
              text: 'Address',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            6.height,
            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CommonText(
              text: 'Cancel',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B2B68),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              setState(() {
                _locations[index]['name'] = nameCtrl.text.trim();
                _locations[index]['address'] = addressCtrl.text.trim();
              });
              Navigator.pop(ctx);
              AppSnackbar.success(
                title: 'Success',
                message: 'Location updated successfully',
              );
            },
            child: const CommonText(
              text: 'Save',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _setAsDefault(int index) {
    setState(() {
      for (int i = 0; i < _locations.length; i++) {
        _locations[i]['isDefault'] = (i == index);
      }
    });
    AppSnackbar.success(
      title: 'Success',
      message: '${_locations[index]['name']} set as default address',
    );
  }

  void _deleteLocation(int index) {
    final name = _locations[index]['name'];
    setState(() {
      _locations.removeAt(index);
    });
    AppSnackbar.success(
      title: 'Deleted',
      message: '$name removed from saved locations',
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
          text: 'Saved Locations',
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
              /// Locations Card Container
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
                  children: List.generate(_locations.length, (index) {
                    final item = _locations[index];
                    final isLast = index == _locations.length - 1;
                    final isHome = item['isHome'] == true;
                    final isDefault = item['isDefault'] == true;

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// Leading Circle Icon
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF1F5F9),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  isHome
                                      ? Icons.home_outlined
                                      : Icons.location_on_outlined,
                                  size: 20.sp,
                                  color: const Color(0xFF1B2B68),
                                ),
                              ),

                              14.width,

                              /// Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: CommonText(
                                            text: item['name']!,
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF0F172A),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (isDefault) ...[
                                          8.width,
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEFF6FF),
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              border: Border.all(
                                                color: const Color(0xFFBFDBFE),
                                                width: 0.8,
                                              ),
                                            ),
                                            child: const CommonText(
                                              text: 'Default',
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF2563EB),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    3.height,
                                    CommonText(
                                      text: item['address']!,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ],
                                ),
                              ),

                              8.width,

                              /// 3-Dot Dropdown Menu (Image 4 Design)
                              PopupMenuButton<String>(
                                child: Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 1.0,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.more_vert_rounded,
                                    size: 17.sp,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                                color: Colors.white,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                  side: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                    width: 1.0,
                                  ),
                                ),
                                offset: const Offset(-10, 36),
                                onSelected: (value) {
                                  if (value == 'default') {
                                    _setAsDefault(index);
                                  } else if (value == 'edit') {
                                    _showEditAddressDialog(index);
                                  } else if (value == 'delete') {
                                    _deleteLocation(index);
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  /// 1. Set as Default
                                  PopupMenuItem<String>(
                                    value: 'default',
                                    height: 42.h,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          size: 19.sp,
                                          color: const Color(0xFF10B981),
                                        ),
                                        12.width,
                                        const CommonText(
                                          text: 'Set as Default',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// 2. Edit Location
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    height: 42.h,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 19.sp,
                                          color: const Color(0xFF64748B),
                                        ),
                                        12.width,
                                        const CommonText(
                                          text: 'Edit Location',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// 3. Delete
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    height: 42.h,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline_rounded,
                                          size: 19.sp,
                                          color: const Color(0xFFEF4444),
                                        ),
                                        12.width,
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

              18.height,

              /// + Add New Address Button
              GestureDetector(
                onTap: _showAddAddressDialog,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4FD),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: const Color(0xFFD4E0FC),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 20.sp,
                        color: const Color(0xFF1B2B68),
                      ),
                      6.width,
                      const CommonText(
                        text: 'Add New Address',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B2B68),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
