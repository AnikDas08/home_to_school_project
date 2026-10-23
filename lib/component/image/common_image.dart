import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/log/error_log.dart';

class CommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;

  final BoxFit fill;

  const CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.contain,
    this.defaultImage = AppImages.profile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (imageSrc.contains('assets/icons')) {
      return _buildSvgImage();
    } else if (imageSrc.contains('assets/images')) {
      return _buildPngImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      height: size?.sp ?? height?.h,
      width: size?.sp ?? width?.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: Icon(
        Icons.image_outlined,
        size: (size != null ? size! * 0.5 : (height ?? 24) * 0.5).sp,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildNetworkImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: size?.sp ?? height?.h,
        width: size?.sp ?? width?.w,
        imageUrl: imageSrc.startsWith('http')
            ? imageSrc
            : '${ApiEndPoint.imageUrl}$imageSrc',
        fit: fill,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(image: imageProvider, fit: fill),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) {
          errorLog(error, source: 'Common Image');

          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      imageSrc,
      colorFilter: imageColor != null
          ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
          : null,
      height: size?.sp ?? height?.h,
      width: size?.sp ?? width?.w,
      fit: fill,
      placeholderBuilder: (_) => _buildErrorWidget(),
    );
  }

  Widget _buildPngImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imageSrc,
        color: imageColor,
        height: size?.sp ?? height?.h,
        width: size?.sp ?? width?.w,
        fit: fill,
        errorBuilder: (context, error, stackTrace) {
          errorLog(error, source: 'Common Image');
          return _buildErrorWidget();
        },
      ),
    );
  }
}
