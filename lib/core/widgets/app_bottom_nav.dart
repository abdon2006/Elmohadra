import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class AppBottomNav extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;

  const AppBottomNav({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  static const List<({String labelKey, List<List<dynamic>>? icon})> _items = [
    (labelKey: 'home', icon: HugeIcons.strokeRoundedHome05),
    (labelKey: 'subjects', icon: HugeIcons.strokeRoundedGitbook),
    (labelKey: '', icon: null),
    (labelKey: 'vault', icon: HugeIcons.strokeRoundedAsteroid01),
    (labelKey: 'profile', icon: HugeIcons.strokeRoundedUser02),
  ];

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(36.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          bool isSelected = currentIndex == i;
          final item = _items[i];
          return (item.icon != null)
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: AnimatedScale(
                    scale: isSelected ? 1.05 : 1,
                    duration: Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () => onTap(i),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HugeIcon(
                            icon: item.icon!,
                            color: isSelected
                                ? theme.primary
                                : theme.onSurface.withValues(alpha: 0.5),
                          ),
                          Text(
                            item.labelKey,
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: isSelected
                                  ? theme.primary
                                  : theme.onSurface.withValues(alpha: 0.5),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink();
        }),
      ),
    );
  }
}
