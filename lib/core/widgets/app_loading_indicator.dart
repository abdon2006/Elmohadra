import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;
  final int? duration;

  const AppLoadingIndicator({super.key, this.color, this.size, this.duration});

  @override
  Widget build(BuildContext context) {
    return SpinKitDancingSquare(
      duration: Duration(seconds: duration ?? 1),
      size: size ?? 48.sp,
      color: color ?? AppColors.accent,
    );
  }
}
