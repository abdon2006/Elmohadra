import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class AppFab extends StatefulWidget {
  const new({super.key});

  @override
  State<AppFab> createState() => _AppFabState();
}

class _AppFabState extends State<AppFab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accent,
      elevation: 8,
      shadowColor: AppColors.accent.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        splashColor: AppColors.onAccent.withValues(alpha: 0.3),
        highlightColor: AppColors.onAccent.withValues(alpha: 0.1),
        child: Ink(
          height: 60.w,
          width: 60.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent,
          ),
          child: Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedAdventure,
              color: AppColors.onAccent,
            ),
          ),
        ),
      ),
    );
  }
}
