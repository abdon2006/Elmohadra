import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_curves.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/features/auth/presentation/blocs/signup_cubit/signup_cubit.dart';
import 'package:elmohadra/features/auth/presentation/blocs/signup_cubit/signup_cubit_state.dart';
import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';
import 'package:elmohadra/features/characters/presentation/bloc/character_bloc.dart';
import 'package:elmohadra/features/characters/presentation/states/character_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryScreen extends StatefulWidget {
  final VoidCallback onReady;

  const SummaryScreen({super.key, required this.onReady});

  @override
  State<SummaryScreen> createState() => SummaryScreenState();
}

class SummaryScreenState extends State<SummaryScreen> {
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration(seconds: 5), () {
        widget.onReady.call();
        setState(() => isReady = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubitState = context.read<SignupCubit>().state;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CharacterBloc, CharacterStates>(
            builder: (context, state) {
              if (state is GetCharactersSuccess) {
                final selectedCharacter = state.characters
                    .where((c) => c.characterKey == cubitState.avatarKey)
                    .toList()
                    .first;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildSelectedCharacterImage(
                      characterKey: cubitState.avatarKey,
                      characters: state.characters,
                      characterImageUrl: selectedCharacter.imageUrl,
                    ),
                    buildSelectedCharacterInfo(
                      selectedCharacter: selectedCharacter,
                      characters: state.characters,
                      context: context,
                    ),

                    buildInfoPreview(context: context, state: cubitState),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

Widget buildSelectedCharacterImage({
  required String characterKey,
  required String characterImageUrl,
  required List<CharacterEntity> characters,
}) {
  return Center(
    child: AppAnimatedEntry(
      delay: const Duration(milliseconds: 700),
      child: Container(
        height: 140.w,
        width: 140.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.2),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipOval(
          child: Padding(
            padding: EdgeInsets.all(3.w), // مسافة أمان صغيرة جوة البوردر
            child: ClipOval(
              child: Image.network(characterImageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildSelectedCharacterInfo({
  required CharacterEntity selectedCharacter,
  required List<CharacterEntity> characters,
  required BuildContext context,
}) {
  bool isArabic = context.read<LocaleCubit>().state.isArabic;
  return AppAnimatedEntry(
    delay: const Duration(milliseconds: 1200),
    child: AnimatedSwitcher(
      duration: AppDuration.normal,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Text(
            isArabic ? selectedCharacter.nameAr : selectedCharacter.nameEn,
            style: AppTypography.sectionTitle(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
              color: AppColors.accent,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              isArabic ? selectedCharacter.titleAr : selectedCharacter.titleEn,
              style: AppTypography.muted(context).copyWith(fontSize: 13.sp),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildInfoPreview({
  required BuildContext context,
  required SignupCubitState state,
}) {
  final theme = Theme.of(context).colorScheme;
  final isGoogle = state.password == null;

  return AnimatedContainer(
    duration: AppDuration.normal,
    curve: AppCurves.standard,
    margin: EdgeInsets.symmetric(
      horizontal: AppSpacing.md.w,
      vertical: AppSpacing.md.h,
    ),
    padding: EdgeInsets.all(AppSpacing.lg.w),
    decoration: BoxDecoration(
      color: theme.surface,
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 2000),
                  child: Text("الاسم", style: AppTypography.muted(context)),
                ),
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 2300),
                  child: Text(
                    state.name,
                    style: AppTypography.cardTitle(context)
                        .copyWith(color: AppColors.accent),
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 2600),
                  child: Text(
                    "اسم الشهرة",
                    style: AppTypography.muted(context),
                  ),
                ),
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 3000),
                  child: Text(
                    state.nickName,
                    style: AppTypography.cardTitle(context)
                        .copyWith(color: AppColors.accent),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 3400),
                  child: Text(
                    "السنة الدراسية",
                    style: AppTypography.muted(context),
                  ),
                ),
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 3700),
                  child: Text(
                    "${state.academicYear}",
                    style: AppTypography.cardTitle(context)
                        .copyWith(color: AppColors.accent),
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 4000),
                  child: Text("الجامعة", style: AppTypography.muted(context)),
                ),
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 4200),
                  child: Text(
                    state.universityName,
                    style: AppTypography.cardTitle(context)
                        .copyWith(color: AppColors.accent),
                  ),
                ),
              ],
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
          child: Divider(
            color: AppColors.lightTextMuted.withValues(alpha: 0.3),
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: AppAnimatedEntry(
            delay: Duration(milliseconds: 4500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Center(
                    child: Text(
                      state.email,
                      style: GoogleFonts.exo2(
                        fontSize: 13.sp,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
                if (isGoogle) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF4285F4).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Center(
                      child: Text(
                        "Google",
                        style: AppTypography.bodySmall(context)
                            .copyWith(color: Color(0xFF4285F4)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
