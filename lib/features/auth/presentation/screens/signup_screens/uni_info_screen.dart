import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_vaildators.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UniInfoScreen extends StatefulWidget {
  final VoidCallback? onChanged;

  const UniInfoScreen({super.key, this.onChanged});

  @override
  State<UniInfoScreen> createState() => UniInfoScreenState();
}

class UniInfoScreenState extends State<UniInfoScreen> {
  final TextEditingController universityController = TextEditingController();

  int? selectedAcademicYear;
  String? _universityError;
  String? _academicYearError;

  @override
  void initState() {
    super.initState();
    universityController.addListener(() {
      setState(() {});
      widget.onChanged?.call();
    });
  }

  List<int> academicYears = [1, 2, 3, 4];

  @override
  void dispose() {
    universityController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    setState(() {
      _universityError = AppValidators.university(universityController.text);
      if (selectedAcademicYear == null) {
        _academicYearError = '';
      } else {
        _academicYearError = null;
      }
    });
    return _universityError == null && _academicYearError == null;
  }

  bool isDisabled() =>
      universityController.text.isEmpty || selectedAcademicYear == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppAnimatedEntry(
            delay: Duration(milliseconds: 100),
            child: Text(
              "signup.step3.title".tr(),
              style: AppTypography.screenTitle(context)
                  .copyWith(fontSize: 32.sp),
            ),
          ),
          AppAnimatedEntry(
            delay: Duration(milliseconds: 300),
            child: Text(
              "signup.step3.subtitle".tr(),
              style: AppTypography.muted(context).copyWith(fontSize: 16.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. حقل الكلية/الجامعة
                AppAnimatedEntry(
                  delay: Duration(milliseconds: 500),
                  child: AppTextField(
                    hint: "signup.step3.university_hint".tr(),
                    label: "signup.step3.university_label".tr(),
                    isPass: false,
                    controller: universityController,
                    errorText: _universityError,
                  ),
                ),

                SizedBox(height: AppSpacing.lg.h),

                AppAnimatedEntry(
                  delay: Duration(milliseconds: 600),
                  child: Text(
                    "signup.step3.year_label".tr(),
                    style: AppTypography.sectionTitle(context),
                  ),
                ),
                SizedBox(height: AppSpacing.sm.h),

                Wrap(
                  spacing: 8.w,
                  runSpacing: 10.h,
                  children: academicYears.map((year) {
                    final isSelected = selectedAcademicYear == year;
                    return AppAnimatedEntry(
                      delay: Duration(milliseconds: (year + 7) * 100),
                      child: ChoiceChip(
                        label: Text(
                          "$year",
                          style: AppTypography.bodySmall(context).copyWith(
                            color: isSelected
                                ? AppColors.onAccent
                                : AppColors.lightTextMuted,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.accent,
                        backgroundColor: theme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.accent
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        showCheckmark: false,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedAcademicYear = selected ? year : null;
                            if (_academicYearError != null)
                              _academicYearError = null;
                          });
                          widget.onChanged?.call();
                        },
                      ),
                    );
                  }).toList(),
                ),

                // 4. عرض الخطأ الخاص بالسنة الدراسية لو مكنتش متحددة وداس "التالي"
                if (_academicYearError != null) ...[
                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    _academicYearError!,
                    style: AppTypography.bodySmall(context)
                        .copyWith(color: AppColors.error),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
