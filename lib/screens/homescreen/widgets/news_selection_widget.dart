import 'package:flutter/material.dart';
import 'package:newso/consts/app_text_style.dart';

class NewsSelectionWidget extends StatelessWidget {
  const NewsSelectionWidget(
      {super.key,
      required this.title,
      required this.function,
      required this.color,
      required this.fontSize,
      required this.weignt,
      required this.textColor});
  final String title;
  final Function function;
  final Color color;
  final double fontSize;
  final FontWeight weignt;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: AppTextStyle.instance
                .boxTextStyle(fontSize, weignt, textColor, context),
          ),
        ),
      ),
    );
  }
}
