import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_curves.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final String label;
  final bool isPass;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorText;

  const AppTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.isPass,
    required this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final mutedColor = isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: AppDuration.normal,
          style: AppTypography.bodyMedium(context),
          child: Text(widget.label),
        ),
        SizedBox(height: 6.h),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isFocused
                ? theme.surface.withValues(alpha: 0.8)
                : theme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: _isFocused ? AppColors.accent : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            obscureText: widget.isPass ? _obscure : false,
            keyboardType: widget.keyboardType,
            style: AppTypography.bodyMedium(context),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: mutedColor, fontSize: 14.sp),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused ? AppColors.accent : mutedColor,
                    )
                  : null,
              suffixIcon: widget.isPass
                  ? IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: _isFocused ? AppColors.accent : mutedColor,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.xs.h),
        if (widget.errorText != null)
          AnimatedDefaultTextStyle(
            style: AppTypography.bodySmall(context)
                .copyWith(color: AppColors.error),
            duration: AppDuration.normal,
            curve: AppCurves.standard,
            child: Text(widget.errorText!),
          ),
      ],
    );
  }
}
