import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

enum AppButtonType { primary, secondary, outline }

class AppButton extends StatefulWidget {
  final String title;
  final void Function() onTap;
  final AppButtonType type;
  final bool isLoading;
  final List<List<dynamic>>? icon;
  final double? width;
  final double? height;
  final bool? isDisabled;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.type,
    required this.isLoading,
    this.icon,
    this.width,
    this.height,
    this.isDisabled = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool Disabled = widget.isLoading || widget.isDisabled!;
    final bool isPrimary = widget.type == AppButtonType.primary;
    final bool isOutline = widget.type == AppButtonType.outline;
    return AnimatedContainer(
      duration: AppDuration.normal,
      curve: Curves.easeInCubic,
      width: widget.width ?? double.infinity,
      height: widget.height ?? 50.h,
      child: ElevatedButton(
        onPressed: Disabled ? null : widget.onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? AppColors.accent
              : (isOutline ? Colors.transparent : AppColors.darkBgSurface),
          foregroundColor: isPrimary
              ? AppColors.onAccent
              : AppColors.darkTextPrimary,
          disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.4),
          elevation: isPrimary ? 4 : 0,
          shadowColor: isPrimary
              ? AppColors.accent.withValues(alpha: 0.3)
              : Colors.transparent,
          side: isOutline
              ? const BorderSide(color: AppColors.darkDivider, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: widget.isLoading
            ?
              // TODO make a custom loading indicator
              SizedBox(
                height: 22.w,
                width: 22.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: AppDuration.normal,
                    curve: Curves.easeInCubic,
                    style: AppTypography.cardTitle(context).copyWith(
                      color: isPrimary
                          ? Disabled
                                ? isDark
                                      ? AppColors.darkTextMuted
                                      : AppColors.lightTextMuted
                                : AppColors.onAccent
                          : AppColors.darkTextPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(widget.title),
                  ),
                  if (widget.icon != null) ...[
                    SizedBox(width: AppSpacing.xs.w),
                    HugeIcon(
                      icon: widget.icon!,
                      size: 18.sp,
                      color: isPrimary ? AppColors.onAccent : AppColors.accent,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
