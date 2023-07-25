import 'package:flutter/material.dart';
import 'package:newso/consts/app_text_style.dart';

class SelectableTextContentWidget extends StatelessWidget {
  const SelectableTextContentWidget({
    Key? key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      style: AppTextStyle.instance.subTextStyle(fontSize, fontWeight, context),
    );
  }
}
