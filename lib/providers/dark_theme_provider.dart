import 'package:flutter/material.dart';
import 'package:newso/services/dark_theme_service.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemeService darkThemeSetting = DarkThemeService();

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  // * set dart theme function
  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemeSetting.setDarkTheme(value);
    notifyListeners();
  }
}
