import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:toastification/toastification.dart';

enum AppToastType { success, error, warning }

class AppToast {
  static void show({
    required BuildContext context,
    required String title,
    String? description,
    required AppToastType type,
  }) {
    final (color, icon) = switch (type) {
      AppToastType.success => (
        AppColors.success,
        HugeIcons.strokeRoundedCheckmarkCircle02,
      ),
      AppToastType.error => (
        AppColors.error,
        HugeIcons.strokeRoundedCancelCircle,
      ),
      AppToastType.warning => (
        AppColors.warning,
        HugeIcons.strokeRoundedAlertCircle,
      ),
    };

    toastification.showCustom(
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 400),

      builder: (context, holder) => _AppToastWidget(
        title: title,
        description: description,
        color: color,
        icon: icon,
      ),
    );
  }
}

class _AppToastWidget extends StatelessWidget {
  final String title;
  final String? description;
  final Color color;
  final List<List<dynamic>> icon;

  const _AppToastWidget({
    required this.title,
    this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: HugeIcon(icon: icon, color: color, size: 18.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.cardTitle(context)),
                SizedBox(height: 2.h),
                if (description != null)
                  Text(
                    description!,
                    style: AppTypography.bodySmall(context)
                        .copyWith(color: AppColors.darkTextSecondary),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
