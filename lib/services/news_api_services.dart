import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newso/consts/api_consts.dart';
import 'package:newso/consts/http_exceptions.dart';
import 'package:newso/models/news_model.dart';

class NewsApiServices {
  
  //* get all news everything
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "8",
        "page": page.toString(),
        "sortBy": sortBy
      });
      var response = await http.get(uri, headers: {"X-Api-key": APIKEY});
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
      }
      for (var details in data["articles"]) {
        newsTempList.add(details);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  //* get all news top headlines
  static Future<List<NewsModel>> getAllTopTrendingNews() async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
        "country": "in",
      });
      var response = await http.get(uri, headers: {"X-Api-key": APIKEY});
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
      }
      for (var details in data["articles"]) {
        newsTempList.add(details);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  //* search query function
  static Future<List<NewsModel>> searchNewsWithQuery(
      {required String searchQuery}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": searchQuery,
        "pageSize": "10",
        "domains": "techcrunch.com",
      });
      var response = await http.get(uri, headers: {"X-Api-key": APIKEY});
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
      }
      for (var details in data["articles"]) {
        newsTempList.add(details);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
