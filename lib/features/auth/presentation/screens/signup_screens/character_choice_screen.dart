import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_curves.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';
import 'package:elmohadra/features/characters/presentation/bloc/character_bloc.dart';
import 'package:elmohadra/features/characters/presentation/events/character_event.dart';
import 'package:elmohadra/features/characters/presentation/states/character_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class CharacterChoiceScreen extends StatefulWidget {
  final VoidCallback onChanged;

  const CharacterChoiceScreen({super.key, required this.onChanged});

  @override
  State<CharacterChoiceScreen> createState() => CharacterChoiceScreenState();
}

class CharacterChoiceScreenState extends State<CharacterChoiceScreen> {
  List<CharacterEntity> charactersCopy = [];
  int selectedCharacter = 0;
  late String characterKey;

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(GetCharactersEvent());
  }

  bool validateInputs() {
    if (charactersCopy.isEmpty) {
      return false;
    }
    if (selectedCharacter >= charactersCopy.length) {
      return false;
    }
    return !charactersCopy[selectedCharacter].isLocked;
  }

  bool isDisabled() {
    if (charactersCopy.isEmpty) {
      return true;
    }
    if (selectedCharacter >= charactersCopy.length) {
      return true;
    }
    return charactersCopy[selectedCharacter].isLocked;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterBloc, CharacterStates>(
      builder: (context, state) {
        if (state is GetCharactersSuccess) {
          final characters = state.characters;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAnimatedEntry(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "signup.step4.title".tr(),
                  style: AppTypography.sectionTitle(context)
                      .copyWith(fontSize: 26.sp),
                ),
              ),
              SizedBox(height: AppSpacing.xs.h),
              AppAnimatedEntry(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  "signup.step4.subtitle".tr(),
                  style: AppTypography.muted(context),
                ),
              ),

              SizedBox(height: AppSpacing.md.h),
              buildSelectedCharacterImage(
                selectedCharacter: selectedCharacter,
                characters: characters,
              ),
              SizedBox(height: AppSpacing.sm.h),
              buildSelectedCharacterInfo(
                characters: characters,
                context: context,
                selectedCharacter: selectedCharacter,
              ),
              SizedBox(height: AppSpacing.lg.h),

              Expanded(
                child: GridView.builder(
                  itemCount: characters.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: AppSpacing.sm.h,
                    crossAxisSpacing: AppSpacing.sm.w,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, i) {
                    bool isSelected = selectedCharacter == i;
                    bool isLocked = characters[i].isLocked;
                    return buildCharacterShip(
                      onTap: () => setState(() {
                        selectedCharacter = i;
                        if (charactersCopy.isNotEmpty &&
                            i < charactersCopy.length) {
                          characterKey =
                              charactersCopy[selectedCharacter].characterKey;
                          print(characterKey);
                        }
                        validateInputs();

                        widget.onChanged();
                      }),
                      isSelected: isSelected,
                      characters: characters,
                      isLocked: isLocked,
                      i: i,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
      listener: (context, state) {
        if (state is GetCharactersSuccess) {
          setState(() {
            charactersCopy = state.characters;
            if (charactersCopy.isNotEmpty) {
              selectedCharacter = 0;
              characterKey = charactersCopy[0].characterKey;
              widget.onChanged();
            }
          });
        }
      },
    );
  }
}

Widget buildCharacterShip({
  required void Function() onTap,
  required bool isSelected,
  required List<CharacterEntity> characters,
  required int i,
  required bool isLocked,
}) {
  final character = characters[i];
  final borderRadius = BorderRadius.circular(AppRadius.md);
  return AppAnimatedEntry(
    delay: Duration(milliseconds: (i + 6) * 100),
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected && !isLocked ? 1.02 : 1,
        duration: AppDuration.normal,
        curve: AppCurves.standard,
        child: AnimatedContainer(
          duration: AppDuration.normal,
          margin: EdgeInsets.symmetric(
            horizontal: AppSpacing.xs.w,
            vertical: AppSpacing.xs.w,
          ),
          curve: AppCurves.standard,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            boxShadow: isSelected && !isLocked
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.25),
                      blurRadius: 7,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
            border: isSelected && !isLocked
                ? Border.all(color: AppColors.accent, width: 1.5)
                : null,
            borderRadius: borderRadius,
          ),
          // استخدام ClipRRect بـ structural alignment مع الـ borderRadius للخارج
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(character.imageUrl, fit: BoxFit.cover),
                if (isLocked)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedLockKeyhole,
                        color: AppColors.accent,
                        size: 24.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildSelectedCharacterInfo({
  required int selectedCharacter,
  required List<CharacterEntity> characters,
  required BuildContext context,
}) {
  bool isArabic = context.read<LocaleCubit>().state.isArabic;
  return AppAnimatedEntry(
    delay: const Duration(milliseconds: 500),
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
        key: ValueKey<int>(selectedCharacter),
        children: [
          Text(
            isArabic
                ? characters[selectedCharacter].nameAr
                : characters[selectedCharacter].nameEn,
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
              isArabic
                  ? characters[selectedCharacter].titleAr
                  : characters[selectedCharacter].titleEn,
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

Widget buildSelectedCharacterImage({
  required int selectedCharacter,
  required List<CharacterEntity> characters,
}) {
  return Center(
    child: AppAnimatedEntry(
      delay: const Duration(milliseconds: 400),
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
              child: Image.network(
                characters[selectedCharacter].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
