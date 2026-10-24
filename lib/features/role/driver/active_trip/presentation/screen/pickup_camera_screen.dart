import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/controller/driver_active_trip_controller.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/widgets/camera_bracket_corners.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class PickupCameraScreen extends StatefulWidget {
  const PickupCameraScreen({super.key});

  @override
  State<PickupCameraScreen> createState() => _PickupCameraScreenState();
}

class _PickupCameraScreenState extends State<PickupCameraScreen> {
  bool _isPreview = false;
  bool _showShutterFlash = false;
  File? _capturedFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _takeDevicePhoto();
    });
  }

  Future<void> _takeDevicePhoto() async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (file != null) {
        setState(() {
          _capturedFile = File(file.path);
          _isPreview = true;
        });
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
    }
  }

  void _onRetake() {
    setState(() {
      _capturedFile = null;
      _isPreview = false;
    });
    _takeDevicePhoto();
  }

  void _onUsePhoto() {
    if (_capturedFile != null) {
      final controller = Get.find<DriverActiveTripController>();
      controller.onPhotoCaptured(_capturedFile);
      Get.back();
    } else {
      _takeDevicePhoto();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Close Button `✕`
                  GestureDetector(
                    onTap: () => Get.back(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF334155),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),

                  14.width,

                  /// Title & Optional Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup photo proof',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (_isPreview) ...[
                          2.height,
                          Text(
                            'Photo of Leo & Mia seated in the vehicle',
                            style: TextStyle(
                              color: const Color(0xFF94A3B8),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  /// Native Device Camera Picker Button (Allows using physical camera)
                  if (!_isPreview)
                    GestureDetector(
                      onTap: _takeDevicePhoto,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF334155),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.photo_camera_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              16.height,

              /// Camera Viewfinder / Preview Container
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      /// Captured / Live Image
                      _capturedFile != null
                          ? Image.file(
                              _capturedFile!,
                              fit: BoxFit.cover,
                            )
                          : GestureDetector(
                              onTap: _takeDevicePhoto,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                color: const Color(0xFF0F172A),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 64.w,
                                        height: 64.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.08),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          size: 32.sp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      14.height,
                                      Text(
                                        'Tap shutter below to take photo',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      6.height,
                                      Text(
                                        'Opens native camera for Android & iOS',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                      /// Shutter Flash Overlay
                      if (_showShutterFlash)
                        Container(
                          color: Colors.white.withOpacity(0.85),
                        ),

                      /// 4 White Frame Bracket Corners (Only in live camera mode)
                      if (!_isPreview) const CameraBracketCorners(),
                    ],
                  ),
                ),
              ),

              20.height,

              /// Bottom Controls Area
              if (!_isPreview)
                /// Live Camera Mode: Big White Shutter Button
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    bottom: bottomPadding > 0 ? bottomPadding : 12.h,
                  ),
                  child: GestureDetector(
                    onTap: _takeDevicePhoto,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 72.w,
                      height: 72.w,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.5.w,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              else
                /// Preview Mode: "Retake" and "Use photo" buttons
                Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding > 0 ? bottomPadding : 12.h,
                  ),
                  child: Row(
                    children: [
                      /// Retake Button
                      Expanded(
                        child: GestureDetector(
                          onTap: _onRetake,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: const Color(0xFF334155),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.refresh_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                8.width,
                                Text(
                                  'Retake',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      12.width,

                      /// Use Photo Button (Orange `#EA580C`)
                      Expanded(
                        child: GestureDetector(
                          onTap: _onUsePhoto,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEA580C),
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFEA580C).withOpacity(0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                8.width,
                                Text(
                                  'Use photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
