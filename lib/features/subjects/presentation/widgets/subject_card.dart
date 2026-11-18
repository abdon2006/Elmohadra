import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class SubjectCard extends StatelessWidget {
  final VoidCallback onTap;
  final SubjectEntity subject;

  const SubjectCard({super.key, required this.subject, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final muted = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Material(
      color: theme.surface,
      elevation: 1,
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
                          Container(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppRadius.md.r,
                              ),
                              color: isDark
                                  ? theme.onSurface.withValues(alpha: 0.1)
                                  : AppColors.accent.withValues(alpha: 0.1),
                            ),
                            child: Center(
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedDatabaseSearch,
                                color: isDark
                                    ? theme.onSurface
                                    : AppColors.accent,
                                size: 32,
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacing.md.w),
                          Expanded(
                            child: Text(
                              subject.title,
                              style: AppTypography.sectionTitle(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      Row(
                        children: [
                          Text(
                            '${subject.completedFiles}/${subject.filesCount} معركة ',
                            style: AppTypography.bodySmall(context),
                          ),
                          SizedBox(width: AppSpacing.xs.h),
                          Text(
                            '${subject.chapterCount} شابتر',
                            style: AppTypography.bodySmall(context),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: subject.fileProgress,
                              color: AppColors.accent,

                              backgroundColor: muted.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(
                                AppRadius.md.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.md.h),
                      Row(
                        children: [
                          Text(
                            subject.fileProgress == 0
                                ? 'ابدا اول معركة'
                                : 'كمل مراجعتك',
                            style: AppTypography.muted(context),
                          ),
                          Spacer(),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowLeft01,
                            color: muted,
                            size: 16.sp,
                          ),
                        ],
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
