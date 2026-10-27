import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_vaildators.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CredentialScreen extends StatefulWidget {
  final VoidCallback? onChanged;

  const CredentialScreen({super.key, this.onChanged});

  @override
  State<CredentialScreen> createState() => CredentialScreenState();
}

class CredentialScreenState extends State<CredentialScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  String? _passError;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
      widget.onChanged?.call();
    });
    passController.addListener(() {
      setState(() {});
      widget.onChanged?.call();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    setState(() {
      _emailError = AppValidators.email(emailController.text);
      _passError = AppValidators.password(passController.text);
    });
    return _emailError == null && _passError == null;
  }

  bool isDisabled() =>
      emailController.text.isEmpty || passController.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAnimatedEntry(
              delay: Duration(milliseconds: 100),
              child: Text(
                "signup.step1.title".tr(),
                style: AppTypography.screenTitle(context)
                    .copyWith(fontSize: 32.sp),
              ),
            ),
            AppAnimatedEntry(
              delay: Duration(milliseconds: 300),
              child: Text(
                "signup.step1.subtitle".tr(),
                style: AppTypography.muted(context).copyWith(fontSize: 16.sp),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.lg.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAnimatedEntry(
                    delay: Duration(milliseconds: 500),
                    child: AppTextField(
                      hint: "signup.step1.email_hint".tr(),
                      label: "signup.step1.email_label".tr(),
                      isPass: false,
                      controller: emailController,
                      errorText: _emailError,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  AppAnimatedEntry(
                    delay: Duration(milliseconds: 700),
                    child: AppTextField(
                      hint: "signup.step1.password_hint".tr(),
                      label: "signup.step1.password_label".tr(),
                      isPass: true,
                      controller: passController,
                      errorText: _passError,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
