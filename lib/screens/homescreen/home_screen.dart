import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/commonwidgets/empty_news_widget.dart.dart';
import 'package:newso/commonwidgets/loading_widget.dart';
import 'package:newso/consts/enum_variables.dart';
import 'package:newso/consts/routes.dart';
import 'package:newso/models/news_model.dart';
import 'package:newso/providers/news_provider.dart';
import 'package:newso/screens/homescreen/widgets/article_widget.dart';
import 'package:newso/screens/homescreen/widgets/drawer_widget.dart';
import 'package:newso/screens/homescreen/widgets/news_selection_widget.dart';
import 'package:newso/screens/homescreen/widgets/pagination_button_widget.dart';
import 'package:newso/screens/homescreen/widgets/top_trending_widget.dart';
import 'package:newso/screens/searchscreen/search_screen.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:newso/services/get_theme_color_service.dart';
import 'package:newso/services/global_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByNews.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        GlobalServices.instance.appDialogue(context, "Are you sure to LogOut",
            () async {
          SystemNavigator.pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
        drawer: const DrawerWidget(),
        //! appbar
        appBar: AppBar(
          title: const Text(
            'NEWSO',
          ),
          actions: [
            IconButton(
              onPressed: () {
                Routes.instance.push(
                  context: context,
                  newScreen: const SearchScreen(),
                );
              },
              icon: const Icon(IconlyLight.search),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            children: [
              //! news selection containers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //! selection container for all news
                  NewsSelectionWidget(
                    title: 'All news',
                    color: newsType == NewsType.allNews
                        ? GetThemeColorService(context).getPaginationColor
                        : Theme.of(context).cardColor,
                    function: () {
                      if (newsType == NewsType.allNews) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.allNews;
                      });
                    },
                    fontSize: newsType == NewsType.allNews ? 22 : 15,
                    weignt: newsType == NewsType.allNews
                        ? FontWeight.w700
                        : FontWeight.w500,
                    textColor: newsType == NewsType.allNews
                        ? GetThemeColorService(context).getCommonTextColor
                        : GetThemeColorService(context).getColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  //! selection container for top trending
                  NewsSelectionWidget(
                    title: 'Top trending',
                    color: newsType == NewsType.topTrending
                        ? GetThemeColorService(context).getPaginationColor
                        : Theme.of(context).cardColor,
                    function: () {
                      if (newsType == NewsType.topTrending) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.topTrending;
                      });
                    },
                    fontSize: newsType == NewsType.topTrending ? 22 : 15,
                    weignt: newsType == NewsType.topTrending
                        ? FontWeight.w700
                        : FontWeight.w500,
                    textColor: newsType == NewsType.topTrending
                        ? GetThemeColorService(context).getCommonTextColor
                        : GetThemeColorService(context).getColor,
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 20),
              newsType == NewsType.topTrending
                  ? Container()
                  : SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //! pagination button only for all news "pre"
                          PaginationButtonWidget(
                              title: "Pre",
                              onPressed: () {
                                if (currentPageIndex == 0) {
                                  return;
                                }
                                setState(() {
                                  currentPageIndex -= 1;
                                });
                              }),
                          //! pagination inner buttons
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () {
                                        //* to change the index
                                        setState(() {
                                          currentPageIndex = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: currentPageIndex == index
                                                ? GetThemeColorService(context)
                                                    .getPaginationColor
                                                : Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: currentPageIndex == index
                                                    ? Colors.white
                                                    : GetThemeColorService(
                                                            context)
                                                        .getMainTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          //! pagination button only for all news "next"
                          PaginationButtonWidget(
                              title: "Next",
                              onPressed: () {
                                if (currentPageIndex == 9) {
                                  return;
                                }
                                setState(() {
                                  currentPageIndex += 1;
                                });
                              }),
                        ],
                      ),
                    ),
              const VerticalSpacingWidget(height: 10),
              //! dropdown button only for all news
              newsType == NewsType.topTrending
                  ? Container()
                  : Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: DropdownButton(
                              underline: const SizedBox(),
                              value: sortBy,
                              items: dropDownItems,
                              onChanged: (newValue) {
                                setState(() {
                                  sortBy = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
              const VerticalSpacingWidget(height: 10),
              //! fetch data from api
              FutureBuilder<List<NewsModel>>(
                future: newsType == NewsType.allNews
                    ? newsProvider.fetchAllNews(
                        pageIndex: currentPageIndex + 1, sortByNews: sortBy)
                    : newsProvider.fetchAllTopTrendingNews(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? LoadingWidget(newsType: newsType)
                        : Expanded(
                            child: LoadingWidget(newsType: newsType),
                          );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: EmptyNewsWidget(
                        text: snapshot.error.toString(),
                        animation: "assets/animations/error.json",
                        animationHeight: 200,
                        animationWidth: 200,
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Expanded(
                      child: EmptyNewsWidget(
                        text: "No news found",
                        animation: "assets/animations/no_news.json",
                        animationHeight: 200,
                        animationWidth: 200,
                      ),
                    );
                  } else {
                    return newsType == NewsType.allNews
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ChangeNotifierProvider.value(
                                  value: snapshot.data![index],
                                  child: const ArticleWidget(),
                                );
                              },
                            ),
                          )
                        : SizedBox(
                            height: 470.h,
                            child: Swiper(
                              autoplayDelay: 5000,
                              autoplay: true,
                              layout: SwiperLayout.STACK,
                              itemWidth: 310.w,
                              viewportFraction: 0.9,
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                return ChangeNotifierProvider.value(
                                  value: snapshot.data![index],
                                  child: const TopTrendingWidget(),
                                );
                              }),
                            ),
                          );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  //* dropdown button items
  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByNews.relevancy.name,
        child: Text(SortByNews.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByNews.publishedAt.name,
        child: Text(SortByNews.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByNews.popularity.name,
        child: Text(SortByNews.popularity.name),
      ),
    ];
    return menuItem;
  }
}
