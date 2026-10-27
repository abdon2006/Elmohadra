import 'package:easy_localization/easy_localization.dart';

abstract class AppValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'validation.required'.tr();
    final regex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
    if (!regex.hasMatch(value)) return 'validation.invalid_email'.tr();
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'validation.required'.tr();
    if (value.length < 8) return 'validation.password_length'.tr();
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
    if (!regex.hasMatch(value)) return 'validation.password_format'.tr();
    return null;
  }

  static String? nickname(String? value) {
    if (value == null || value.isEmpty) return 'validation.required'.tr();
    if (value.length < 3) return 'validation.nickname_min'.tr();
    if (value.length > 20) return 'validation.nickname_max'.tr();
    if (value.contains(' ')) return 'validation.nickname_no_spaces'.tr();
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return 'validation.required'.tr();
    if (value.length < 3) return 'validation.name_min'.tr();
    return null;
  }

  static String? university(String? value) {
    if (value == null || value.isEmpty) return 'validation.required'.tr();
    if (value.length < 3) return 'validation.university_min'.tr();
    return null;
  }
}
