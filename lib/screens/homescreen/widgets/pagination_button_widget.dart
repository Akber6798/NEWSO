import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/services/get_theme_color_service.dart';

class PaginationButtonWidget extends StatelessWidget {
  const PaginationButtonWidget(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: GetThemeColorService(context).getPaginationColor,
        padding: const EdgeInsets.all(8),
        textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      child: Text(title),
    );
  }
}
