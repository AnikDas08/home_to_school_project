import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/services/storage/storage_keys.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverVehicleInfoScreen extends StatefulWidget {
  const DriverVehicleInfoScreen({super.key});

  @override
  State<DriverVehicleInfoScreen> createState() =>
      _DriverVehicleInfoScreenState();
}

class _DriverVehicleInfoScreenState extends State<DriverVehicleInfoScreen> {
  late final TextEditingController _makeController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _colourController;
  late final TextEditingController _plateController;
  late final TextEditingController _seatsController;

  String _selectedType = '';
  File? _pickedPhoto;
  final ImagePicker _picker = ImagePicker();

  final List<String> _vehicleTypes = const [
    'Minivan',
    'Sedan',
    'SUV',
    'Van',
    'Hatchback',
    'Electric / Hybrid',
  ];

  @override
  void initState() {
    super.initState();
    _selectedType = LocalStorage.vehicleType.isNotEmpty
        ? LocalStorage.vehicleType
        : '';

    _makeController = TextEditingController(
      text: LocalStorage.vehicleMake.isNotEmpty
          ? LocalStorage.vehicleMake
          : 'Toyota',
    );
    _modelController = TextEditingController(
      text: LocalStorage.vehicleModel.isNotEmpty
          ? LocalStorage.vehicleModel
          : 'Sienna',
    );
    _yearController = TextEditingController(
      text: LocalStorage.vehicleYear.isNotEmpty
          ? LocalStorage.vehicleYear
          : '2023',
    );
    _colourController = TextEditingController(
      text: LocalStorage.vehicleColour.isNotEmpty
          ? LocalStorage.vehicleColour
          : 'Celestial Silver',
    );
    _plateController = TextEditingController(
      text: LocalStorage.vehiclePlate.isNotEmpty
          ? LocalStorage.vehiclePlate
          : 'SCH-4091',
    );
    _seatsController = TextEditingController(
      text: LocalStorage.vehicleSeats.isNotEmpty
          ? LocalStorage.vehicleSeats
          : '4',
    );

    if (LocalStorage.vehiclePhoto.isNotEmpty) {
      final file = File(LocalStorage.vehiclePhoto);
      if (file.existsSync()) {
        _pickedPhoto = file;
      }
    }
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colourController.dispose();
    _plateController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  /// Responsive vehicle type bottom sheet picker
  void _showVehicleTypePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Drag handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),

                Row(
                  children: [
                    const Expanded(
                      child: CommonText(
                        text: 'Select Vehicle Type',
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),

                12.height,
                const Divider(color: Color(0xFFF1F5F9), height: 1),
                8.height,

                ..._vehicleTypes.map((type) {
                  final isSelected = _selectedType == type;
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedType = type);
                      Navigator.pop(ctx);
                    },
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      margin: EdgeInsets.only(bottom: 4.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF1F5F9)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CommonText(
                              text: type,
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFF1B2B68)
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_rounded,
                              size: 20,
                              color: Color(0xFF1B2B68),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Vehicle Photo Selector
  void _showPhotoSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Drag handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),

                const CommonText(
                  text: 'Upload Vehicle Photo',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
                4.height,
                const CommonText(
                  text: 'JPG or PNG photo of your vehicle exterior',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),

                18.height,

                /// 1. Gallery
                _buildSourceTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: const Color(0xFF1B2B68),
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'Choose from Gallery',
                  subtitle: 'Select from photos library',
                  onTap: () async {
                    Navigator.pop(ctx);
                    final img = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 85,
                    );
                    if (img != null) {
                      setState(() => _pickedPhoto = File(img.path));
                    }
                  },
                ),

                10.height,

                /// 2. Camera
                _buildSourceTile(
                  icon: Icons.camera_alt_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                  title: 'Take a Photo',
                  subtitle: 'Snap a new vehicle photo',
                  onTap: () async {
                    Navigator.pop(ctx);
                    final img = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 85,
                    );
                    if (img != null) {
                      setState(() => _pickedPhoto = File(img.path));
                    }
                  },
                ),

                if (_pickedPhoto != null) ...[
                  10.height,
                  _buildSourceTile(
                    icon: Icons.delete_outline_rounded,
                    iconColor: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    title: 'Remove Photo',
                    subtitle: 'Clear vehicle photo',
                    onTap: () {
                      Navigator.pop(ctx);
                      setState(() => _pickedPhoto = null);
                    },
                  ),
                ],

                16.height,

                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
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

  Widget _buildSourceTile({
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
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9.r),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            12.width,
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
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Save changes to LocalStorage
  void _onSave() {
    final make = _makeController.text.trim();
    final model = _modelController.text.trim();
    final year = _yearController.text.trim();
    final colour = _colourController.text.trim();
    final plate = _plateController.text.trim();
    final seats = _seatsController.text.trim();

    if (_selectedType.isNotEmpty) {
      LocalStorage.vehicleType = _selectedType;
      LocalStorage.setString(LocalStorageKeys.vehicleType, _selectedType);
    }
    if (make.isNotEmpty) {
      LocalStorage.vehicleMake = make;
      LocalStorage.setString(LocalStorageKeys.vehicleMake, make);
    }
    if (model.isNotEmpty) {
      LocalStorage.vehicleModel = model;
      LocalStorage.setString(LocalStorageKeys.vehicleModel, model);
    }
    if (year.isNotEmpty) {
      LocalStorage.vehicleYear = year;
      LocalStorage.setString(LocalStorageKeys.vehicleYear, year);
    }
    if (colour.isNotEmpty) {
      LocalStorage.vehicleColour = colour;
      LocalStorage.setString(LocalStorageKeys.vehicleColour, colour);
    }
    if (plate.isNotEmpty) {
      LocalStorage.vehiclePlate = plate;
      LocalStorage.setString(LocalStorageKeys.vehiclePlate, plate);
    }
    if (seats.isNotEmpty) {
      LocalStorage.vehicleSeats = seats;
      LocalStorage.setString(LocalStorageKeys.vehicleSeats, seats);
    }
    if (_pickedPhoto != null) {
      LocalStorage.vehiclePhoto = _pickedPhoto!.path;
      LocalStorage.setString(LocalStorageKeys.vehiclePhoto, _pickedPhoto!.path);
    } else {
      LocalStorage.vehiclePhoto = '';
      LocalStorage.setString(LocalStorageKeys.vehiclePhoto, '');
    }

    Get.back();

    AppSnackbar.success(
      title: 'Success',
      message: 'Vehicle information saved successfully',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.white,

        /// App Bar matching design: "Your vehicle"
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
            text: 'Your vehicle',
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

        /// Form Body
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 1. Type
                      _buildLabel('Type'),
                      6.height,
                      GestureDetector(
                        onTap: _showVehicleTypePicker,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 48.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
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
                              Expanded(
                                child: Text(
                                  _selectedType,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF0F172A),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),

                      14.height,

                      /// 2. Row 1: Make & Model
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Make'),
                                6.height,
                                _buildInputField(
                                  controller: _makeController,
                                  hintText: 'Make',
                                ),
                              ],
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Model'),
                                6.height,
                                _buildInputField(
                                  controller: _modelController,
                                  hintText: 'Model',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      14.height,

                      /// 3. Row 2: Year & Colour
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Year'),
                                6.height,
                                _buildInputField(
                                  controller: _yearController,
                                  hintText: 'Year',
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Colour'),
                                6.height,
                                _buildInputField(
                                  controller: _colourController,
                                  hintText: 'Colour',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      14.height,

                      /// 4. Row 3: Plate & Seats
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Plate'),
                                6.height,
                                _buildInputField(
                                  controller: _plateController,
                                  hintText: 'Plate',
                                ),
                              ],
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Seats'),
                                6.height,
                                _buildInputField(
                                  controller: _seatsController,
                                  hintText: 'Seats',
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      14.height,

                      /// 5. Vehicle Photo Box
                      _buildLabel('Vehicle photo'),
                      6.height,
                      GestureDetector(
                        onTap: _showPhotoSourceBottomSheet,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.0,
                            ),
                          ),
                          child: _pickedPhoto != null
                              ? Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(
                                        _pickedPhoto!,
                                        width: 50.w,
                                        height: 50.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    14.width,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CommonText(
                                            text: 'Vehicle photo selected',
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF0F172A),
                                          ),
                                          2.height,
                                          const CommonText(
                                            text: 'Tap to change or remove',
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF64748B),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                      color: Color(0xFF1B2B68),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CommonText(
                                      text: 'Vehicle photo',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0F172A),
                                    ),
                                    3.height,
                                    const CommonText(
                                      text: 'JPG or PNG',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      28.height,

                      /// 6. Save Button (Navy Blue)
                      GestureDetector(
                        onTap: _onSave,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B2B68),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x201B2B68),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const CommonText(
                            text: 'Save',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      20.height,
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

  Widget _buildLabel(String text) {
    return CommonText(
      text: text,
      fontSize: 13.5,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF0F172A),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: 1,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
