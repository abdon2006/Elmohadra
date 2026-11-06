import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_vaildators.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_button.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final email = TextEditingController();
  String? _emailError = '';

  @override
  void initState() {
    super.initState();
    email.addListener(
      () => setState(() => _emailError = AppValidators.email(email.text)),
    );
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  bool get isDisabled => _emailError != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "نسيت الباسوورد ؟".tr(),
                      style: AppTypography.screenTitle(context),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => context.pop(),
                        splashColor: AppColors.accent.withValues(alpha: 0.08),
                        customBorder: CircleBorder(),
                        child: Ink(
                          padding: EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.onSurface.withValues(alpha: 0.05),
                          ),
                          child: Center(
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowLeft01,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg.h),
                AppTextField(
                  hint: "email_hint".tr(),
                  label: "email_label".tr(),
                  isPass: false,
                  controller: email,
                  errorText: _emailError,
                ),

                BlocBuilder<AuthBloc, AuthStates>(
                  builder: (_, state) {
                    return AppButton(
                      title: "send_reset".tr(),
                      onTap: () => context.read<AuthBloc>().add(
                        SendResetPasswordLinkEvent(email: email.text.trim()),
                      ),
                      type: AppButtonType.primary,
                      isLoading: state is AuthLoading,
                      isDisabled: isDisabled,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
