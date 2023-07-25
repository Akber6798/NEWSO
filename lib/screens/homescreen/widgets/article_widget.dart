import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/consts/routes.dart';
import 'package:newso/models/news_model.dart';
import 'package:newso/screens/newsdetailscreen/news_detail_screen.dart';
import 'package:newso/screens/newswebviewscreen/news_web_view_screen.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Card(
        elevation: 6,
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, NewsDetailScreen.routeName,
                  arguments: newsModelProvider.publishedAt);
            },
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
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Hero(
                          tag: newsModelProvider.publishedAt,
                          child: FancyShimmerImage(
                            height: 110.h,
                            width: 110.w,
                            boxFit: BoxFit.fill,
                            errorWidget: const Image(
                              image: AssetImage("assets/images/no_image.png"),
                            ),
                            imageUrl: newsModelProvider.urlToImage,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsModelProvider.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.instance
                                  .mainTextStyle(17, FontWeight.w600, context),
                            ),
                            const VerticalSpacingWidget(height: 20),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "🕒  ${newsModelProvider.readingTimeText}",
                                style: AppTextStyle.instance
                                    .subTextStyle(14, FontWeight.w400, context),
                              ),
                            ),
                            const VerticalSpacingWidget(height: 05),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Routes.instance.push(
                                          context: context,
                                          newScreen: NewsWebViewScreen(
                                            newsUrl: newsModelProvider.url,
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.link,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    newsModelProvider.dateToShow,
                                    maxLines: 1,
                                    style: AppTextStyle.instance.textStyle(
                                        14, FontWeight.w500, context),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
