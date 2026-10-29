import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_curves.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/divider_with_icon.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/bloc/sign_up_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/events/sing_up_bloc_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/states/sign_up_bloc_states.dart';
import 'package:elmohadra/features/auth/presentation/blocs/signup_cubit/signup_cubit.dart';
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

import '../../../../../core/widgets/app_button.dart';

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
  int currentScreen = 0;
  late List<Widget> screens = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (screens.isEmpty) {
      final uri = GoRouterState.of(context).uri;
      final email = uri.queryParameters['email'];
      final id = uri.queryParameters['id'];

      bool isGoogle =
          (email != null && email.isNotEmpty) || (id != null && id.isNotEmpty);
      if (isGoogle) {
        context.read<SignupCubit>().initGoogleDate(email: email!);
        screens = [
          NameScreen(key: nameFormKey, onChanged: () => setState(() {})),
          UniInfoScreen(
            key: universityFormKey,
            onChanged: () => setState(() {}),
          ),
          CharacterChoiceScreen(
            key: characterFormKey,
            onChanged: () => setState(() {}),
          ),
          SummaryScreen(),
        ];
      } else {
        screens = [
          CredentialScreen(
            key: credentialFormKey,
            onChanged: () => setState(() {}),
          ),
          NameScreen(key: nameFormKey, onChanged: () => setState(() {})),
          UniInfoScreen(
            key: universityFormKey,
            onChanged: () => setState(() {}),
          ),
          CharacterChoiceScreen(
            key: characterFormKey,
            onChanged: () => setState(() {}),
          ),
          SummaryScreen(),
        ];
      }
    }
  }

  bool get isValidated {
    final currentWidget = screens[currentScreen];

    if (currentWidget is CredentialScreen) {
      return credentialFormKey.currentState?.validateInputs() ?? false;
    } else if (currentWidget is NameScreen) {
      return nameFormKey.currentState?.validateInputs() ?? false;
    } else if (currentWidget is UniInfoScreen) {
      return universityFormKey.currentState?.validateInputs() ?? false;
    } else if (currentWidget is CharacterChoiceScreen) {
      return characterFormKey.currentState?.validateInputs() ?? false;
    }
    return true;
  }

  void handleEventsPerTap({required BuildContext context}) async {
    if (isValidated) {
      final cubit = context.read<SignupCubit>();
      final currentWidget = screens[currentScreen];

      if (currentWidget is CredentialScreen) {
        final state = credentialFormKey.currentState;
        if (state != null) {
          cubit.updateCredentialData(
            email: state.emailController.text.trim(),
            password: state.passController.text,
          );
        }
      } else if (currentWidget is NameScreen) {
        final state = nameFormKey.currentState;
        if (state != null) {
          cubit.updateNameData(
            name: state.nameController.text.trim(),
            nickName: state.nicknameController.text.trim(),
          );
        }
      } else if (currentWidget is UniInfoScreen) {
        final state = universityFormKey.currentState;
        if (state != null) {
          cubit.updateUniversityInfo(
            universityName: state.universityController.text.trim(),
            academicYear: state.selectedAcademicYear ?? 1,
          );
        }
      } else if (currentWidget is CharacterChoiceScreen) {
        final state = characterFormKey.currentState;
        if (state != null) {
          cubit.updateAvatarKey(avatarKey: state.characterKey);
        }
      }

      if (currentScreen < screens.length - 1) {
        setState(() => currentScreen++);
      } else {
        print('Final Signup Data Payload: ${cubit.state}');
        final state = cubit.state;
        context.read<SignUpBloc>().add(
          SignUpEvent(
            params: SignupParams(
              name: state.name,
              nickName: state.nickName,
              password: state.password,
              email: state.email,
              university: state.universityName,
              academicYear: state.academicYear,
              avatarKey: state.avatarKey,
            ),
          ),
        );
      }
    }
  }

  bool get isDisabled {
    final currentWidget = screens[currentScreen];

    if (currentWidget is CredentialScreen) {
      return credentialFormKey.currentState?.isDisabled() ?? true;
    } else if (currentWidget is NameScreen) {
      return nameFormKey.currentState?.isDisabled() ?? true;
    } else if (currentWidget is UniInfoScreen) {
      return universityFormKey.currentState?.isDisabled() ?? true;
    } else if (currentWidget is CharacterChoiceScreen) {
      return characterFormKey.currentState?.isDisabled() ?? true;
    }
    return false;
  }

  Widget _buildHeader() => AnimatedSwitcher(
    duration: AppDuration.normal,
    switchInCurve: AppCurves.standard,
    switchOutCurve: Curves.easeIn,
    child: currentScreen == screens.length - 1
        ? Text(
            key: ValueKey('final_step'),
            'signup.final_title'.tr(),
            style: AppTypography.screenTitle(context),
          )
        : Row(
            key: ValueKey('step'),
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
          ),
  );

  Widget _buildProgressBar() => AnimatedOpacity(
    opacity: currentScreen == screens.length - 1 ? 0 : 1,
    duration: AppDuration.normal,
    curve: AppCurves.standard,
    child: Row(
      children: List.generate(screens.length, (i) {
        bool isDone = currentScreen >= i;
        return Expanded(
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
        );
      }),
    ),
  );

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
                BlocBuilder<SignUpBloc, SignUpStates>(
                  builder: (context, state) {
                    return AppButton(
                      title: currentScreen == screens.length - 1
                          ? "signup.submit".tr()
                          : "signup.next".tr(),
                      onTap: () => handleEventsPerTap(context: context),
                      type: AppButtonType.primary,
                      isLoading: state is SignUpLoading,
                      isDisabled: isDisabled,
                    );
                  },
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
