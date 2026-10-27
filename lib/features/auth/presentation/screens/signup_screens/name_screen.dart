import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_vaildators.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameScreen extends StatefulWidget {
  final VoidCallback? onChanged;

  const NameScreen({super.key, this.onChanged});

  @override
  State<NameScreen> createState() => NameScreenState();
}

class NameScreenState extends State<NameScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _nameError;
  String? _nicknameError;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
      widget.onChanged?.call();
    });
    nicknameController.addListener(() {
      setState(() {});
      widget.onChanged?.call();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    setState(() {
      _nameError = AppValidators.name(nameController.text);
      _nicknameError = AppValidators.nickname(nicknameController.text);
    });
    return _nameError == null && _nicknameError == null;
  }

  bool isDisabled() =>
      nameController.text.isEmpty || nicknameController.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppAnimatedEntry(
              delay: Duration(milliseconds: 100),
              child: Text(
                "signup.step2.title".tr(),
                style: AppTypography.screenTitle(context)
                    .copyWith(fontSize: 32.sp),
              ),
            ),
            AppAnimatedEntry(
              delay: Duration(milliseconds: 300),
              child: Text(
                "signup.step2.subtitle".tr(),
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
                      hint: "signup.step2.name_hint".tr(),
                      label: "signup.step2.name_label".tr(),
                      isPass: false,
                      controller: nameController,
                      errorText: _nameError,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  AppAnimatedEntry(
                    delay: Duration(milliseconds: 700),
                    child: AppTextField(
                      hint: "signup.step2.nickname_hint".tr(),
                      label: "signup.step2.nickname_label".tr(),
                      isPass: false,
                      controller: nicknameController,
                      errorText: _nicknameError,
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
