import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraBracketCorners extends StatelessWidget {
  final double cornerLength;
  final double cornerWidth;
  final Color cornerColor;
  final double cornerRadius;

  const CameraBracketCorners({
    super.key,
    this.cornerLength = 24.0,
    this.cornerWidth = 3.5,
    this.cornerColor = Colors.white,
    this.cornerRadius = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Top-Left
        Positioned(
          top: 16.h,
          left: 16.w,
          child: Container(
            width: cornerLength.w,
            height: cornerLength.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cornerRadius.r),
              ),
              border: Border(
                top: BorderSide(color: cornerColor, width: cornerWidth.w),
                left: BorderSide(color: cornerColor, width: cornerWidth.w),
              ),
            ),
          ),
        ),

        /// Top-Right
        Positioned(
          top: 16.h,
          right: 16.w,
          child: Container(
            width: cornerLength.w,
            height: cornerLength.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(cornerRadius.r),
              ),
              border: Border(
                top: BorderSide(color: cornerColor, width: cornerWidth.w),
                right: BorderSide(color: cornerColor, width: cornerWidth.w),
              ),
            ),
          ),
        ),

        /// Bottom-Left
        Positioned(
          bottom: 16.h,
          left: 16.w,
          child: Container(
            width: cornerLength.w,
            height: cornerLength.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(cornerRadius.r),
              ),
              border: Border(
                bottom: BorderSide(color: cornerColor, width: cornerWidth.w),
                left: BorderSide(color: cornerColor, width: cornerWidth.w),
              ),
            ),
          ),
        ),

        /// Bottom-Right
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: Container(
            width: cornerLength.w,
            height: cornerLength.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(cornerRadius.r),
              ),
              border: Border(
                bottom: BorderSide(color: cornerColor, width: cornerWidth.w),
                right: BorderSide(color: cornerColor, width: cornerWidth.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
