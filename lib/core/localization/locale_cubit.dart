import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/storage_constants.dart';
import 'package:elmohadra/core/localization/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class LocaleCubit extends Cubit<LocaleState> {
  final SharedPreferences _pref;
  LocaleCubit(this._pref) : super(LocaleState()) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final saved = _pref.getString(StorageConstants.locale);
    if (saved != null) {
      emit(state.copyWith(Locale(saved)));
    }
  }

  void setEnglish(BuildContext context) {
    if (state.isArabic) {
      _pref.setString(StorageConstants.locale, 'en');
      context.setLocale(const Locale('en'));
      emit(state.copyWith(Locale('en')));
    }
  }

  void setArabic(BuildContext context) {
    if (!state.isArabic) {
      _pref.setString(StorageConstants.locale, 'ar');
      context.setLocale(const Locale('ar'));
      emit(state.copyWith(Locale('ar')));
    }
  }

  void toggle(BuildContext context) {
    if (state.isArabic) {
      _pref.setString(StorageConstants.locale, 'en');
      context.setLocale(const Locale('en'));
      emit(state.copyWith(Locale('en')));
    } else {
      _pref.setString(StorageConstants.locale, 'ar');
      context.setLocale(const Locale('ar'));
      emit(state.copyWith(Locale('ar')));
    }
  }
}
