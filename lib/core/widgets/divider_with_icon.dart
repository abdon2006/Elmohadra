import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

Widget appDivider({required bool isDark}) => Row(
  children: [
    Expanded(
      child: Divider(
        color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs.w),
      child: HugeIcon(
        icon: HugeIcons.strokeRoundedFlash,
        color: AppColors.accent,
      ),
    ),
    Expanded(
      child: Divider(
        color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
      ),
    ),
  ],
);
