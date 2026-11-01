import 'package:cached_network_image/cached_network_image.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Network image with a loading placeholder and a graceful error fallback, so
/// a broken/unreachable URL never leaves an empty hole in the UI.
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (context, url) => const ColoredBox(
        color: AppColors.darkBgMuted,
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      errorWidget: (context, url, error) => ColoredBox(
        color: AppColors.darkBgMuted,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: AppColors.darkTextMuted,
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
