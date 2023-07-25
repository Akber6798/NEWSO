import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:newso/consts/app_text_style.dart';

class EmptyNewsWidget extends StatelessWidget {
  const EmptyNewsWidget(
      {super.key,
      required this.text,
      required this.animation,
      required this.animationHeight,
      required this.animationWidth});
  final String text;
  final String animation;
  final double animationHeight;
  final double animationWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //! animation
        Flexible(
          child: Lottie.asset(animation,
              height: animationHeight.h, width: animationWidth.w),
        ),
       const VerticalSpacingWidget(height: 10),
       //! error text
        Flexible(
          child: Text(
            text,
            style: AppTextStyle.instance
                .mainTextStyle(25, FontWeight.bold, context),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
