import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/providers/news_provider.dart';
import 'package:newso/screens/newsdetailscreen/widgets/selectable_text_content_widget.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:newso/services/get_theme_color_service.dart';
import 'package:newso/services/global_services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = "/NewsDetailsScreen";
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    //* to read the passed variable from screen by arguments:
    final publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    final detailNews = newsProvider.findByDate(publishedAt: publishedAt);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          detailNews.authorName,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconlyLight.arrowLeft2, size: 30),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const VerticalSpacingWidget(height: 10),
              //! title
              Text(detailNews.title,
                  style: AppTextStyle.instance
                      .mainTextStyle(22, FontWeight.bold, context)),
              VerticalSpacingWidget(height: 20.h),
              Row(
                children: [
                  //! date
                  Text(detailNews.dateToShow,
                      style: AppTextStyle.instance
                          .textStyle(14, FontWeight.w400, context)),
                  const Spacer(),
                  //! reading time
                  Text(detailNews.readingTimeText,
                      style: AppTextStyle.instance
                          .textStyle(14, FontWeight.w400, context)),
                  VerticalSpacingWidget(height: 20.h),
                ],
              ),
              VerticalSpacingWidget(height: 20.h),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Hero(
                          tag: detailNews.publishedAt,
                          //! image
                          child: FancyShimmerImage(
                            boxFit: BoxFit.fill,
                            errorWidget: const Image(
                                image:
                                    AssetImage("assets/images/no_image.png")),
                            imageUrl: detailNews.urlToImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 6.w,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Row(
                        children: [
                          //! for floating icon in image
                          GestureDetector(
                            onTap: () async {
                              try {
                                await Share.share(detailNews.url,
                                    subject: 'Look what I made!');
                              } catch (error) {
                                GlobalServices.instance.errorDialogue(
                                    errorMessage: error.toString(),
                                    context: context);
                              }
                            },
                            child: Card(
                              elevation: 10,
                              shape: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  IconlyLight.send,
                                  size: 26,
                                  color: GetThemeColorService(context).getColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              VerticalSpacingWidget(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                //! description
                child: Text("Description",
                    style: AppTextStyle.instance
                        .mainTextStyle(22, FontWeight.bold, context)),
              ),
              VerticalSpacingWidget(height: 5.h),
              //* for select text
              SelectableTextContentWidget(
                  label: detailNews.description,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              VerticalSpacingWidget(height: 20.h),
              //! content
              Align(
                alignment: Alignment.topLeft,
                child: Text("Content",
                    style: AppTextStyle.instance
                        .mainTextStyle(22, FontWeight.bold, context)),
              ),
              VerticalSpacingWidget(height: 5.h),
              //* for select text
              SelectableTextContentWidget(
                  label: detailNews.content,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
    );
  }
}
