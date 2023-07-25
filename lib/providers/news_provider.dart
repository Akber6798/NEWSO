import 'package:flutter/material.dart';
import 'package:newso/models/news_model.dart';
import 'package:newso/services/news_api_services.dart';

class NewsProvider with ChangeNotifier {
  
  List<NewsModel> allNewsList = [];

  //* fetch all news
  Future<List<NewsModel>> fetchAllNews(
      {required int pageIndex, required String sortByNews}) async {
    allNewsList =
        await NewsApiServices.getAllNews(page: pageIndex, sortBy: sortByNews);
    return allNewsList;
  }

  //*fetch news by date to show single news in news detail screen
  //* in this api, id are same for all news thats we cant use id otherwise we can use id
  NewsModel findByDate({required String? publishedAt}) {
    return allNewsList
        .firstWhere((newsModel) => newsModel.publishedAt == publishedAt);
  }

  //* fetch all topTrending news
  Future<List<NewsModel>> fetchAllTopTrendingNews() async {
    allNewsList = await NewsApiServices.getAllTopTrendingNews();
    return allNewsList;
  }

  //* search news
  Future<List<NewsModel>> searchNews({required String searchQuery}) async {
    allNewsList =
        await NewsApiServices.searchNewsWithQuery(searchQuery: searchQuery);
    return allNewsList;
  }
}
