import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  void changeTheme(ThemeMode newMode) async {
    final pref = await SharedPreferences.getInstance();
    if (newMode == currentTheme) return;
    currentTheme = newMode;
    pref.setString("theme", currentTheme == ThemeMode.light ? "light" : "dark");
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }

  void changeLanguage(String newLocale) async {
    final pref = await SharedPreferences.getInstance();
    if (currentLanguage == newLocale) return;
    currentLanguage = newLocale;
    pref.setString("locale", currentLanguage);
    notifyListeners();
  }

  bool isArabic() {
    return currentLanguage == 'ar';
  }
}
