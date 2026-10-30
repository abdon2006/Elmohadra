import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_assets.dart';
import 'package:elmohadra/core/constants/app_vaildators.dart';
import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/errors/app_error_mapper.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:elmohadra/core/widgets/app_toast.dart';
import 'package:elmohadra/core/widgets/divider_with_icon.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/bloc/sign_in_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/events/sign_in_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/states/sign_in_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/app_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  String? _emailError;
  String? _passwordError;
  final formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void showToastAndDispatch() async {
    AppToast.show(
      context: context,
      title: 'toast.signin_success'.tr(),
      description: 'toast.signin_success_sub'.tr(),
      type: AppToastType.success,
    );
    await Future.delayed((Duration(seconds: 1)));
    getIt<AuthBloc>().add(CheckAuthStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: AppSpacing.sm.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "sign_in".tr(),
                        style: AppTypography.screenTitle(context),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              context.read<LocaleCubit>().toggle(context),
                          splashColor: AppColors.accent.withValues(alpha: 0.08),

                          customBorder: CircleBorder(),
                          child: Ink(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedTranslation,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: isDark
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                  ),
                  Center(
                    child: SizedBox(
                      height: 200.w,
                      width: 200.w,
                      child: SvgPicture.asset(AppAssets.logo),
                    ),
                  ),
                  Text(
                    "battle_continues".tr(),
                    textAlign: TextAlign.center,
                    style: AppTypography.sectionTitle(context),
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    "battle_subtitle".tr(),
                    textAlign: TextAlign.center,
                    style: AppTypography.muted(context)
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: AppSpacing.lg.h),

                  AppTextField(
                    hint: "email_hint".tr(),
                    label: "email_label".tr(),
                    isPass: false,
                    controller: _emailController,
                    validator: (val) => AppValidators.email(val),
                    errorText: _emailError,
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  AppTextField(
                    hint: 'password_hint'.tr(),
                    label: 'password_label'.tr(),
                    isPass: true,
                    controller: _passController,
                    validator: (val) => AppValidators.password(val),
                    errorText: _passwordError,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // TODO: Forgot Password Screen
                        },
                        child: Text(
                          "forgot_password".tr(),
                          style: AppTypography.bodySmall(context).copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),

                  BlocConsumer<SignInBloc, SignInBlocStates>(
                    listener: (context, state) {
                      if (state is SigninBlocError) {
                        AppToast.show(
                          context: context,
                          title: AppErrorTitleMapper.toKey(state.failure).tr(),
                          description: AppErrorDescMapper.toKey(state.failure)
                              ?.tr(),
                          type: AppToastType.error,
                        );
                      }
                      if (state is SigninBlocSuccess) {
                        showToastAndDispatch();
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: 'enter_now'.tr(),
                        onTap: () {
                          setState(() {
                            _emailError = AppValidators.email(
                              _emailController.text,
                            );
                            _passwordError = AppValidators.password(
                              _passController.text,
                            );
                          });

                          if (_emailError == null && _passwordError == null) {
                            context.read<SignInBloc>().add(
                              SignInEvent(
                                params: SigninParams(
                                  email: _emailController.text,
                                  password: _passController.text,
                                ),
                              ),
                            );
                          }
                        },
                        type: AppButtonType.primary,
                        isLoading: state is SigninBlocLoading,
                      );
                    },
                  ),
                  SizedBox(height: AppSpacing.md.h),

                  appDivider(isDark: isDark),
                  SizedBox(height: AppSpacing.md.h),

                  // ── University Account Secondary Button ───────────
                  AppButton(
                    title: 'sign_in_google'.tr(),
                    onTap: () => context.read<AuthBloc>().add(
                      HandleSigningWithGoogleEvent(),
                    ),
                    type: AppButtonType.secondary,
                    isLoading: false,
                  ),
                  SizedBox(height: AppSpacing.lg.h),

                  // ── Register Footer ───────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "dont_have_account".tr(),
                        style: AppTypography.muted(context),
                      ),
                      GestureDetector(
                        onTap: () => context.pushReplacement(AppRoutes.signup),
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
                  SizedBox(height: AppSpacing.lg.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
