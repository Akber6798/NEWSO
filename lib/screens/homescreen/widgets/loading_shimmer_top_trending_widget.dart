import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerTopTrendingWidget extends StatelessWidget {
  const LoadingShimmerTopTrendingWidget(
      {super.key,
      required this.highlightShimmerColor,
      required this.baseShimmerColor,
      required this.widgetShimmerColor});
  final Color highlightShimmerColor;
  final Color baseShimmerColor;
  final Color widgetShimmerColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Shimmer.fromColors(
          baseColor: baseShimmerColor,
          highlightColor: highlightShimmerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! image
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 300.h,
                    width: double.infinity,
                    color: widgetShimmerColor,
                  )),
              const VerticalSpacingWidget(height: 10),
              //! title
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    color: widgetShimmerColor,
                  )),
              const VerticalSpacingWidget(height: 10),
              //! date
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipOval(
                    child: Container(
                      height: 30.h,
                      width: 70.w,
                      color: widgetShimmerColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
