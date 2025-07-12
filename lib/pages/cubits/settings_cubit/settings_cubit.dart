import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/const.dart';
import 'package:notes/pages/cubits/settings_cubit/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void changeLang({required Locale newLocale}) async {
    bool isEn = newLocale.languageCode == 'en';
    SharedPreferences prf = await SharedPreferences.getInstance();
    prf.setBool(kLangEn, isEn);
    emit(SettingsChangeLang(isEn: isEn));
  }
}
