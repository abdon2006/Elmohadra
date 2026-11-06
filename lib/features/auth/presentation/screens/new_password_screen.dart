import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_vaildators.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_button.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:elmohadra/core/widgets/divider_with_icon.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPassScreen extends StatefulWidget {
  const NewPassScreen({super.key});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  late final TextEditingController pass;
  late final TextEditingController passConfirm;
  String? _passError = '';
  String? _passConfirmError = '';

  @override
  void initState() {
    super.initState();
    pass = TextEditingController();
    passConfirm = TextEditingController();

    pass.addListener(() {
      setState(() {
        _passError = AppValidators.password(pass.text);
        // Editing the first field can break a match that was already valid.
        if (passConfirm.text.isNotEmpty) {
          _passConfirmError = _confirmError(passConfirm.text);
        }
      });
    });

    passConfirm.addListener(() {
      setState(() => _passConfirmError = _confirmError(passConfirm.text));
    });
  }

  @override
  void dispose() {
    pass.dispose();
    passConfirm.dispose();
    super.dispose();
  }

  String? _confirmError(String value) {
    return value == pass.text ? null : 'validation.password_mismatch'.tr();
  }

  bool get isDisabled => _passError != null || _passConfirmError != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "متنساش الباسوورد تاني ".tr(),
                      style: AppTypography.screenTitle(context),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg.h),
                appDivider(isDark: isDark),

                SizedBox(height: AppSpacing.lg.h),
                AppTextField(
                  hint: "new_password_hint".tr(),
                  label: "new_password_label".tr(),
                  isPass: true,
                  controller: pass,
                  errorText: _passError,
                ),

                SizedBox(height: AppSpacing.sm.h),
                AppTextField(
                  hint: "new_password_confirm_hint".tr(),
                  label: "new_password_confirm_label".tr(),
                  isPass: true,
                  controller: passConfirm,
                  errorText: _passConfirmError,
                ),

                SizedBox(height: AppSpacing.md.h),
                BlocBuilder<AuthBloc, AuthStates>(
                  builder: (_, state) {
                    return AppButton(
                      title: "save_password".tr(),
                      onTap: () => context.read<AuthBloc>().add(
                        UpdatePasswordEvent(password: pass.text),
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
