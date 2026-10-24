import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/widgets/camera_bracket_corners.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/controller/walkshare_active_walk_controller.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalksharePickupCameraScreen extends StatefulWidget {
  const WalksharePickupCameraScreen({super.key});

  @override
  State<WalksharePickupCameraScreen> createState() =>
      _WalksharePickupCameraScreenState();
}

class _WalksharePickupCameraScreenState
    extends State<WalksharePickupCameraScreen> {
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
      final controller = Get.find<WalkshareActiveWalkController>();
      controller.onPhotoCaptured(_capturedFile);
      Get.back();
    } else {
      _takeDevicePhoto();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          /// Viewfinder / Photo Area
          Positioned.fill(
            top: topPadding + 60.h,
            bottom: bottomPadding + 130.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (_capturedFile != null)
                    Image.file(
                      _capturedFile!,
                      fit: BoxFit.cover,
                    )
                  else
                    GestureDetector(
                      onTap: _takeDevicePhoto,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        color: const Color(0xFF1E293B),
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

                  /// Bracket corners
                  if (!_isPreview) const CameraBracketCorners(),

                  /// White flash animation on capture
                  if (_showShutterFlash)
                    Container(
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),

          /// Top Bar
          Positioned(
            top: topPadding + 10.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                12.width,
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
                      2.height,
                      Text(
                        'Photo of children walking together',
                        style: TextStyle(
                          color: const Color(0xFF94A3B8),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Controls
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: bottomPadding + 20.h,
            child: _isPreview
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _onRetake,
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Retake',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF334155)),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                        ),
                      ),
                      14.width,
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _onUsePhoto,
                          icon: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Use photo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEA580C),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _takeDevicePhoto,
                        icon: const Icon(
                          Icons.camera_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: _takeDevicePhoto,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
