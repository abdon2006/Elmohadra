import 'dart:ui';

class LocaleState {
  final Locale locale;

  LocaleState({this.locale = const Locale('ar')});

  bool get isArabic => locale.languageCode == 'ar';

  LocaleState copyWith(Locale? newLocale) {
    return LocaleState(locale: newLocale ?? locale);
  }
}
