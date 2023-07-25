import 'package:flutter/material.dart';
import 'package:newso/consts/app_colors.dart';
import 'package:newso/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class GetThemeColorService {

  BuildContext context;

  GetThemeColorService(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).darkTheme;

  //* get text color
  Color get getColor => getTheme ? darkTextColor : lightTextColor;

  //* pagination box color
  Color get getPaginationColor => getTheme ? darkIconsColor : lightIconsColor;

  //* main text color
  Color get getMainTextColor =>
      getTheme ? darkMainTextColor : lightMainTextColor;

  //* sub text color
  Color get getSubTextColor => getTheme ? darkSubTextColor : lightSubTextColor;

  //* common text color 
  Color get getCommonTextColor => getTheme ? darkTextColor : darkTextColor;

  //* for shimmer
  Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;

  Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;
}
