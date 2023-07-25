// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newso/consts/app_colors.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/services/get_theme_color_service.dart';

class ThemeStyle {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? darkScaffoldColor : lightScaffoldColor,
      primaryColor: isDarkTheme ? darkCardColor : lightCardColor,
      backgroundColor: isDarkTheme ? darkBackgroundColor : lightBackgroundColor,
      hintColor: isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade700,
      //* for text selection
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: isDarkTheme ? darkTextColor : lightTextColor,
        selectionColor: linkColor,
      ),
      //* text color theme
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: isDarkTheme ? darkTextColor : lightTextColor,
            displayColor: isDarkTheme ? darkTextColor : lightTextColor,
          ),
      cardColor: isDarkTheme ? darkCardColor : lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isDarkTheme ? darkIconsColor : lightIconsColor,
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      //* appbar
      appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme ? darkScaffoldColor : lightScaffoldColor,
          iconTheme: IconThemeData(
              color: GetThemeColorService(context).getPaginationColor),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: AppTextStyle.instance
              .mainTextStyle(22, FontWeight.bold, context)),
    );
  }
}
