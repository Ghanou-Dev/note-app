import 'package:flutter/material.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool langEn = true;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          locale.settings,
          style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
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
                  fontSize: 16,
                ),
              ),
              ListTile(
                tileColor: primaryColor,
                leading: Icon(Icons.translate, color: secondaryColor),
                title: Text(langEn ? "العربية" : "English"),
                trailing: Icon(Icons.restart_alt, color: secondaryColor),
                onTap: () {
                  Locale currentLocale = Localizations.localeOf(context);
                  Locale newLocale = currentLocale.languageCode == 'en'
                      ? const Locale("ar")
                      : const Locale("en");
                  Notes.setLocale(context, newLocale);
                  setState(() {
                    langEn = !langEn;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
