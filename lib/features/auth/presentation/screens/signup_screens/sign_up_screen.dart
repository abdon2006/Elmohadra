import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_curves.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_button.dart';
import 'package:elmohadra/core/widgets/divider_with_icon.dart';
import 'package:elmohadra/features/auth/presentation/screens/signup_screens/character_choice_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/signup_screens/credential_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/signup_screens/name_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/signup_screens/summary_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/signup_screens/uni_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final credentialFormKey = GlobalKey<CredentialScreenState>();
  final nameFormKey = GlobalKey<NameScreenState>();
  final universityFormKey = GlobalKey<UniInfoScreenState>();
  final characterFormKey = GlobalKey<CharacterChoiceScreenState>();
  bool isFromGoogle = false;

  @override
  void initState() {
    super.initState();
    // isFromGoogle = context.read<AuthBloc>().state == Auth
  }

  bool get isValidated => switch (currentScreen) {
    0 => credentialFormKey.currentState?.validateInputs() ?? false,
    1 => nameFormKey.currentState?.validateInputs() ?? false,
    2 => universityFormKey.currentState?.validateInputs() ?? false,
    3 => characterFormKey.currentState?.validateInputs() ?? false,
    _ => false,
  };

  bool get isDisabled => switch (currentScreen) {
    0 => credentialFormKey.currentState?.isDisabled() ?? true,
    1 => nameFormKey.currentState?.isDisabled() ?? true,
    2 => universityFormKey.currentState?.isDisabled() ?? true,
    3 => characterFormKey.currentState?.isDisabled() ?? true,
    _ => false,
    //
  };

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "signup.header_title".tr(),
        style: AppTypography.screenTitle(context),
      ),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.read<LocaleCubit>().toggle(context),
          splashColor: AppColors.accent.withValues(alpha: 0.08),

          customBorder: CircleBorder(),
          child: Ink(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: HugeIcon(icon: HugeIcons.strokeRoundedTranslation),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildProgressBar() => Row(
    children: List.generate(screens.length, (i) {
      bool isDone = currentScreen >= i;
      return Expanded(
        child: AnimatedOpacity(
          opacity: currentScreen == screens.length - 1 ? 0 : 1,
          duration: AppDuration.slow,
          curve: AppCurves.standard,
          child: AnimatedContainer(
            duration: AppDuration.slow,
            curve: AppCurves.standard,
            height: 8.h,
            margin: EdgeInsets.symmetric(
              horizontal: AppSpacing.xs.w,
              vertical: AppSpacing.lg.h,
            ),
            decoration: BoxDecoration(
              color: isDone
                  ? AppColors.accent
                  : AppColors.lightTextMuted.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        ),
      );
    }),
  );

  late final List<Widget> screens = [
    CredentialScreen(key: credentialFormKey, onChanged: () => setState(() {})),
    NameScreen(key: nameFormKey, onChanged: () => setState(() {})),
    UniInfoScreen(key: universityFormKey, onChanged: () => setState(() {})),
    CharacterChoiceScreen(
      key: characterFormKey,
      onChanged: () => setState(() {}),
    ),
    SummaryScreen(),
  ];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
            child: Column(
              children: [
                _buildHeader(),
                appDivider(isDark: isDark),
                _buildProgressBar(),
                SizedBox(height: AppSpacing.md.h),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: AppDuration.normal,
                      child: screens[currentScreen],
                    ),
                  ),
                ),
                AppButton(
                  title: currentScreen == screens.length - 1
                      ? "signup.submit".tr()
                      : "signup.next".tr(),
                  onTap: () {
                    if (isValidated) {
                      setState(() => currentScreen++);
                    }
                  },
                  type: AppButtonType.primary,
                  isLoading: false,
                  // TODO handle loading state using Bloc
                  isDisabled: isDisabled,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "signup.already_have_account".tr(),
                        style: AppTypography.muted(context),
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutes.signin),
                        child: Text(
                          "create_one".tr(),
                          style: AppTypography.bodySmall(context).copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
