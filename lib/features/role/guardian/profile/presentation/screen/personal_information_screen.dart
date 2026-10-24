import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/controller/driver_role_profile_controller.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/controller/guardian_profile_controller.dart';
import 'package:home_to_school/services/storage/storage_keys.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  String _selectedRelationship = 'Mother';
  final List<String> _relationships = [
    'Mother',
    'Father',
    'Legal Guardian',
    'Grandparent',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    String initialName = 'Sadia Khan';
    final isDriverRole = LocalStorage.role.toLowerCase() == 'driver' ||
        LocalStorage.role.toLowerCase() == 'walkshare';

    if (isDriverRole) {
      if (Get.isRegistered<DriverRoleProfileController>() &&
          Get.find<DriverRoleProfileController>().name.isNotEmpty) {
        initialName = Get.find<DriverRoleProfileController>().name;
      } else if (LocalStorage.myName.isNotEmpty) {
        initialName = LocalStorage.myName;
      } else {
        initialName = 'Robert MacDonald';
      }
    } else {
      if (Get.isRegistered<GuardianProfileController>() &&
          Get.find<GuardianProfileController>().name.isNotEmpty) {
        initialName = Get.find<GuardianProfileController>().name;
      } else if (LocalStorage.myName.isNotEmpty) {
        initialName = LocalStorage.myName;
      }
    }

    final defaultEmail = isDriverRole
        ? 'robert.macdonald@example.com'
        : 'sadia.khan@example.com';

    _nameController = TextEditingController(text: initialName);
    _phoneController = TextEditingController(text: '(416) 555-0192');
    _emailController = TextEditingController(
      text: LocalStorage.myEmail.isNotEmpty
          ? LocalStorage.myEmail
          : defaultEmail,
    );
    _addressController =
        TextEditingController(text: '12 Elm Street, Toronto, ON');

    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// Pick image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
      }
    } catch (e) {
      AppSnackbar.error(
        title: 'Error',
        message: 'Failed to pick image: $e',
      );
    }
  }

  /// Bottom sheet to choose between Gallery, Camera, or Remove
  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),

                /// Title & subtitle
                const CommonText(
                  text: 'Change Profile Photo',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                4.height,
                const CommonText(
                  text: 'Select an image from gallery or take a new photo',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                  textAlign: TextAlign.center,
                ),

                20.height,

                /// Choose from Gallery
                _buildImageSourceTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select an existing photo from your library',
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),

                12.height,

                /// Take a Photo
                _buildImageSourceTile(
                  icon: Icons.camera_alt_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                  title: 'Take a Photo',
                  subtitle: 'Use your camera to capture a new photo',
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),

                if (_pickedImage != null || LocalStorage.myImage.isNotEmpty) ...[
                  12.height,

                  /// Remove Current Photo
                  _buildImageSourceTile(
                    icon: Icons.delete_outline_rounded,
                    iconColor: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    title: 'Remove Current Photo',
                    subtitle: 'Reset to the default profile avatar',
                    onTap: () {
                      Navigator.of(ctx).pop();
                      setState(() {
                        _pickedImage = null;
                      });
                      LocalStorage.myImage = '';
                      LocalStorage.image = '';
                      LocalStorage.setString(LocalStorageKeys.myImage, '');
                      if (Get.isRegistered<DriverRoleProfileController>()) {
                        Get.find<DriverRoleProfileController>().update();
                      }
                      if (Get.isRegistered<GuardianProfileController>()) {
                        Get.find<GuardianProfileController>().update();
                      }
                    },
                  ),
                ],

                16.height,

                /// Cancel button
                GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12.r),
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20.sp,
              ),
            ),
            14.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  2.height,
                  CommonText(
                    text: subtitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF94A3B8),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  /// Avatar image renderer supporting newly picked image, cached LocalStorage file, or fallback asset
  Widget _buildAvatarImage(double width, double height) {
    if (_pickedImage != null) {
      return Image.file(
        _pickedImage!,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
    if (LocalStorage.myImage.isNotEmpty) {
      final file = File(LocalStorage.myImage);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      }
    }
    return Image.asset(
      AppImages.profileImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => CircleAvatar(
        radius: (width / 2).r,
        backgroundColor: const Color(0xFFEFF6FF),
        child: Icon(
          Icons.person,
          size: 40.sp,
          color: const Color(0xFF1B2B68),
        ),
      ),
    );
  }

  void _onSaveChanges() {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      LocalStorage.myName = newName;
      LocalStorage.setString(LocalStorageKeys.myName, newName);
    }
    final newEmail = _emailController.text.trim();
    if (newEmail.isNotEmpty) {
      LocalStorage.myEmail = newEmail;
      LocalStorage.setString(LocalStorageKeys.myEmail, newEmail);
    }

    if (_pickedImage != null) {
      LocalStorage.myImage = _pickedImage!.path;
      LocalStorage.image = _pickedImage!.path;
      LocalStorage.setString(LocalStorageKeys.myImage, _pickedImage!.path);
    }

    if (Get.isRegistered<DriverRoleProfileController>()) {
      final driverCtrl = Get.find<DriverRoleProfileController>();
      if (newName.isNotEmpty) {
        driverCtrl.name = newName;
      }
      driverCtrl.update();
    }

    if (Get.isRegistered<GuardianProfileController>()) {
      final profileCtrl = Get.find<GuardianProfileController>();
      if (newName.isNotEmpty) {
        profileCtrl.name = newName;
      }
      profileCtrl.roleDescription = 'Parent ($_selectedRelationship)';
      profileCtrl.update();
    }

    Get.back();

    AppSnackbar.success(
      title: 'Success',
      message: 'Profile updated successfully',
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
          text: 'Personal Information',
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

      /// Body Form
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    /// Avatar with Camera Edit Badge (interactive)
                    Center(
                      child: GestureDetector(
                        onTap: _showImageSourceBottomSheet,
                        behavior: HitTestBehavior.opaque,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 86.w,
                              height: 86.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 2.w,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0A0F172A),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(44.r),
                                child: _buildAvatarImage(86.w, 86.w),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(7.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B2B68),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5.w,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x251B2B68),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    10.height,

                    /// Name with Verified Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: _nameController.text.isNotEmpty
                              ? _nameController.text
                              : 'Sadia Khan',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        6.width,
                        Icon(
                          Icons.check_circle_rounded,
                          size: 16.sp,
                          color: const Color(0xFF38BDF8),
                        ),
                      ],
                    ),

                    20.height,

                    /// Card Form
                    Container(
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
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 1. Full Legal Name
                          _buildFieldLabel('Full Legal Name'),
                          6.height,
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Full Legal Name',
                          ),

                          14.height,

                          /// 2. Relationship to Children (Dropdown)
                          _buildFieldLabel('Relationship to Children'),
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
                                value: _selectedRelationship,
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
                                items: _relationships.map((rel) {
                                  return DropdownMenuItem(
                                    value: rel,
                                    child: Text(rel),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _selectedRelationship = val);
                                  }
                                },
                              ),
                            ),
                          ),

                          14.height,

                          /// 3. Phone Number with Country Code
                          _buildFieldLabel('Phone Number'),
                          6.height,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 13.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '🇨🇦',
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      4.width,
                                      Text(
                                        '+1',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                      4.width,
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 16.sp,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1.w,
                                  height: 28.h,
                                  color: const Color(0xFFE2E8F0),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF0F172A),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                        vertical: 13.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          14.height,

                          /// 4. Email Address
                          _buildFieldLabel('Email Address'),
                          6.height,
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          14.height,

                          /// 5. Primary Address
                          _buildFieldLabel('Primary Address'),
                          6.height,
                          _buildTextField(
                            controller: _addressController,
                            hint: 'Primary Address',
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Icon(
                                Icons.my_location_rounded,
                                size: 18.sp,
                                color: const Color(0xFF1B2B68),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Save Changes Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: GestureDetector(
                onTap: _onSaveChanges,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2B68),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: const CommonText(
                    text: 'Save Changes',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return CommonText(
      text: text,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF64748B),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    Widget? suffixIcon,
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
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 13.h,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
