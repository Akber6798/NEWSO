import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/consts/enum_variables.dart';
import 'package:newso/screens/homescreen/widgets/loading_shimmer_article_widget.dart';
import 'package:newso/screens/homescreen/widgets/loading_shimmer_top_trending_widget.dart';
import 'package:newso/services/get_theme_color_service.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key, required this.newsType});

  final NewsType newsType;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  late Color baseShimmerColor, highlightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = GetThemeColorService(context);
    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.newsType == NewsType.topTrending
        ? Swiper(
            autoplayDelay: 6000,
            autoplay: true,
            itemWidth: 310.w,
            layout: SwiperLayout.STACK,
            viewportFraction: 0.9,
            itemCount: 5,
            itemBuilder: (context, index) {
              return LoadingShimmerTopTrendingWidget(
                baseShimmerColor: baseShimmerColor,
                highlightShimmerColor: highlightShimmerColor,
                widgetShimmerColor: widgetShimmerColor,
              );
            },
          )
        : Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (ctx, index) {
                  return LoadingShimmerArticleWidget(
                    baseShimmerColor: baseShimmerColor,
                    highlightShimmerColor: highlightShimmerColor,
                    widgetShimmerColor: widgetShimmerColor,
                  );
                }),
          );
  }
}
