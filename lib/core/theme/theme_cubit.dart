import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(ThemeMode.dark);

  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  Future<void> load() async {
    final value = _prefs.getString(_key);
    switch (value) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.dark);
    }
  }

  void setLight() {
    _prefs.setString(_key, 'light');
    emit(ThemeMode.light);
  }

  void setDark() {
    _prefs.setString(_key, 'dark');
    emit(ThemeMode.dark);
  }

  void setSystem() {
    _prefs.setString(_key, 'system');
    emit(ThemeMode.system);
  }

  void toggle() {
    final next = state == ThemeMode.dark ? 'light' : 'dark';
    _prefs.setString(_key, next);
    emit(next == 'light' ? ThemeMode.light : ThemeMode.dark);
  }
}