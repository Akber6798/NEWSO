import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newso/services/get_theme_color_service.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle();

  TextStyle mainTextStyle(
      double fSize, FontWeight fWeight, BuildContext context) {
    return GoogleFonts.bitter(
        fontSize: fSize.sp,
        color: GetThemeColorService(context).getMainTextColor,
        fontWeight: fWeight);
  }

  TextStyle boxTextStyle(
      double fSize, FontWeight fWeight, Color color, BuildContext context) {
    return GoogleFonts.bitter(
        fontSize: fSize.sp, color: color, fontWeight: fWeight);
  }

  TextStyle subTextStyle(
      double fSize, FontWeight fWeight, BuildContext context) {
    return GoogleFonts.roboto(
        fontSize: fSize.sp,
        color: GetThemeColorService(context).getColor,
        fontWeight: fWeight);
  }

  TextStyle textStyle(double fSize, FontWeight fWeight, BuildContext context) {
    return GoogleFonts.roboto(
        fontSize: fSize.sp,
        color: GetThemeColorService(context).getSubTextColor,
        fontWeight: fWeight);
  }
}
