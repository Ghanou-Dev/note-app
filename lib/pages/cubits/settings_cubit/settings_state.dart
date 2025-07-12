abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsChangeLang extends SettingsState {
  final bool isEn;
  SettingsChangeLang({required this.isEn});
}
