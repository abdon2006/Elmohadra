import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectCard extends StatelessWidget {
  final int index;
  final String title;
  final int chapterCount;
  final VoidCallback? onTap;

  const SubjectCard({
    super.key,
    required this.index,
    required this.title,
    required this.chapterCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final muted = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md.w,
                    vertical: AppSpacing.md.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            index.toString().padLeft(2, '0'),
                            style: AppTypography.statNumber(context)
                                .copyWith(color: scheme.primary),
                          ),
                          SizedBox(width: AppSpacing.sm.w),
                          Expanded(
                            child: Text(
                              title,
                              style: AppTypography.sectionTitle(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.chevron_left, color: muted, size: 20.sp),
                        ],
                      ),
                      SizedBox(height: AppSpacing.xs.h),
                      Text(
                        'chapters_count'.tr(args: ['$chapterCount']),
                        style: AppTypography.muted(context),
                      ),
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
}
