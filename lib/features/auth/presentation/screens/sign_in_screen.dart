import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_assets.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/bloc/sign_in_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/events/sign_in_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/states/sign_in_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppSpacing.sm.h),


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

                // ── Text Fields ───────────────────────────────────
                AppTextField(
                  hint: "email_hint".tr(),
                  label: "email_label".tr(),
                  isPass: false,
                  controller: _emailController,
                ),
                SizedBox(height: AppSpacing.md.h),
                AppTextField(
                  hint: 'password_hint'.tr(),
                  label: 'password_label'.tr(),
                  isPass: true,
                  controller: _passController,
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

                BlocBuilder<SignInBloc, SignInBlocStates>(
                  builder: (context, state) {
                    return AppButton(
                      title: 'enter_now'.tr(),
                      onTap: () {
                        context.read<SignInBloc>().add(
                          SignInEvent(
                            params: SigninParams(
                              email: _emailController.text,
                              password: _passController.text,
                            ),
                          ),
                        );
                      },
                      type: AppButtonType.primary,
                      isLoading: state is SigninBlocLoading,
                    );
                  },
                ),
                SizedBox(height: AppSpacing.md.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm.w,
                      ),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedFlash,
                        color: AppColors.accent,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md.h),

                // ── University Account Secondary Button ───────────
                AppButton(
                  title: 'sign_in_google'.tr(),
                  onTap: () {},
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
                      onTap: () {
                        // TODO: Navigate to Sign Up Screen
                      },
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
    );
  }
}
