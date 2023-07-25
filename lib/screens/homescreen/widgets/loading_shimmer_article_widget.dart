import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerArticleWidget extends StatelessWidget {
  const LoadingShimmerArticleWidget({
    super.key,
    required this.highlightShimmerColor,
    required this.baseShimmerColor,
    required this.widgetShimmerColor,
  });

  final Color highlightShimmerColor;
  final Color baseShimmerColor;
  final Color widgetShimmerColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Card(
        elevation: 6,
        child: Stack(
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
              ),
              //! image
              child: Shimmer.fromColors(
                highlightColor: highlightShimmerColor,
                baseColor: baseShimmerColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 110.h,
                        width: 110.w,
                        color: widgetShimmerColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! title
                          Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: widgetShimmerColor),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! reading time
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 20.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: widgetShimmerColor),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          FittedBox(
                            child: Row(
                              children: [
                                ClipOval(
                                  //! Link
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: widgetShimmerColor),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                //! date
                                Container(
                                  height: 24.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: widgetShimmerColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
