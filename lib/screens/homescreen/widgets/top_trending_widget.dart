import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/consts/app_colors.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/models/news_model.dart';
import 'package:newso/screens/newsdetailscreen/news_detail_screen.dart';
import 'package:newso/screens/newswebviewscreen/news_web_view_screen.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NewsDetailScreen.routeName,
              arguments: newsModelProvider.publishedAt);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Hero(
                tag: newsModelProvider.publishedAt,
                //! image
                child: FancyShimmerImage(
                    height: 300.h,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    errorWidget: const Image(
                        image: AssetImage("assets/images/no_image.png")),
                    imageUrl: newsModelProvider.urlToImage),
              ),
            ),
            const VerticalSpacingWidget(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              //! title
              child: Text(
                newsModelProvider.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.instance
                    .mainTextStyle(22, FontWeight.bold, context),
              ),
            ),
            const VerticalSpacingWidget(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: NewsWebViewScreen(
                              newsUrl: newsModelProvider.url,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.link, color: linkColor)),
                  const Spacer(),
                  //! date
                  SelectableText(
                    newsModelProvider.dateToShow,
                    style: AppTextStyle.instance
                        .textStyle(15, FontWeight.w400, context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
