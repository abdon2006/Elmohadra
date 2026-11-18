import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class AppPageHeader extends StatelessWidget {
  final bool showBack;
  final String title;

  const AppPageHeader({super.key, required this.title, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTypography.screenTitle(context),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ),
        if (showBack)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.pop(),
              child: Ink(
                padding: EdgeInsets.all(AppSpacing.sm.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.surface.withValues(alpha: 0.3),
                ),
                child: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
              ),
            ),
          ),
      ],
    );
  }
}
