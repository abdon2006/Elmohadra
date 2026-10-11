import 'package:elmohadra/core/constants/storage_constants.dart';
import 'package:elmohadra/core/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@LazySingleton()
class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _pref;
  ThemeCubit(this._pref) : super(ThemeState()) {
    _loadSavedTheme();
  }

  void _loadSavedTheme() {
    final saved = _pref.getString(StorageConstants.theme);
    if (saved != null) {
      if (saved == 'dark') {
        emit(state.copyWith(newTheme: AppThemeMode.dark));
      } else if (saved == 'light') {
        emit(state.copyWith(newTheme: AppThemeMode.light));
      }
    }
  }

  void setSystem() {
    _pref.setString(StorageConstants.theme, 'system');
    emit(state.copyWith(newTheme: AppThemeMode.system));
  }

  void setDark() {
    _pref.setString(StorageConstants.theme, 'dark');
    emit(state.copyWith(newTheme: AppThemeMode.dark));
  }

  void setLight() {
    _pref.setString(StorageConstants.theme, 'light');
    emit(state.copyWith(newTheme: AppThemeMode.light));
  }

  void toggle() {
    if (state.isDark) {
      _pref.setString(StorageConstants.theme, 'light');
      emit(state.copyWith(newTheme: AppThemeMode.light));
    } else {
      _pref.setString(StorageConstants.theme, 'dark');
      emit(state.copyWith(newTheme: AppThemeMode.dark));
    }
  }
}
