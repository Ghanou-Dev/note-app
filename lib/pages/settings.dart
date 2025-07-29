import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/main.dart';
import 'package:notes/pages/cubits/settings_cubit/settings_cubit.dart';
import 'package:notes/pages/cubits/settings_cubit/settings_state.dart';
import 'package:notes/widgets/item_language.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            locale.settings,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: forthColor),
                Text(
                  locale.general,
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.translate, color: secondaryColor, size: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        locale.language,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 9,
                  child: ListView(
                    children: [
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          final isEn =
                              Localizations.localeOf(context).languageCode ==
                              'en';
                          if (state is SettingsChangeLang) {
                            final isEng = state.isEn;
                            return ItemLanguage(
                              language: 'English',
                              isActive: isEng ? true : false,
                              onTap: () {
                                Locale currentLocal = Localizations.localeOf(
                                  context,
                                );
                                Locale newLocale =
                                    currentLocal.languageCode == 'en'
                                    ? Locale('ar')
                                    : Locale('en');
                                Notes.setLocale(context, newLocale);
                                context.read<SettingsCubit>().changeLang(
                                  newLocale: newLocale,
                                );
                              },
                            );
                          }
                          return ItemLanguage(
                            language: 'English',
                            isActive: isEn ? true : false,
                            onTap: () {
                              Locale currentLocal = Localizations.localeOf(
                                context,
                              );
                              Locale newLocale =
                                  currentLocal.languageCode == 'en'
                                  ? Locale('ar')
                                  : Locale('en');
                              Notes.setLocale(context, newLocale);
                              context.read<SettingsCubit>().changeLang(
                                newLocale: newLocale,
                              );
                            },
                          );
                        },
                      ),
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          final isEn =
                              Localizations.localeOf(context).languageCode ==
                              'en';
                          if (state is SettingsChangeLang) {
                            final isEng = state.isEn;
                            return ItemLanguage(
                              language: 'العربية',
                              isActive: isEng ? false : true,
                              onTap: () {
                                Locale currentLocal = Localizations.localeOf(
                                  context,
                                );
                                Locale newLocale =
                                    currentLocal.languageCode == 'en'
                                    ? Locale('ar')
                                    : Locale('en');
                                Notes.setLocale(context, newLocale);
                                context.read<SettingsCubit>().changeLang(
                                  newLocale: newLocale,
                                );
                              },
                            );
                          }
                          return ItemLanguage(
                            language: 'العربية',
                            isActive: isEn ? false : true,
                            onTap: () {
                              Locale currentLocal = Localizations.localeOf(
                                context,
                              );
                              Locale newLocale =
                                  currentLocal.languageCode == 'en'
                                  ? Locale('ar')
                                  : Locale('en');
                              Notes.setLocale(context, newLocale);
                              context.read<SettingsCubit>().changeLang(
                                newLocale: newLocale,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Divider(color: forthColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
