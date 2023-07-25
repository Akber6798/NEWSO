import 'package:flutter/material.dart';
import 'package:newso/services/global_services.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier {
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
      dateToShow,
      readingTimeText;

  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });
 

  //* get function
  factory NewsModel.fromJson(dynamic json) {
    String newsTitle = json["title"] ?? "";
    String newsContent = json["content"] ?? "";
    String newsDescription = json["description"] ?? "";
    //* for format date from publishedAt
    String formatedDateToShow = "Date is not available";
    if (json["publishedAt"] != null) {
      formatedDateToShow =
          GlobalServices.instance.formatDate(json["publishedAt"]);
    }
    return NewsModel(
      newsId: json["source"]["id"] ?? "",
      sourceName: json["source"]["name"] ?? "",
      authorName: json["author"] ?? "",
      title: newsTitle,
      description: newsDescription,
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ??
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
      publishedAt: json["publishedAt"] ?? "",
      content: newsContent,
      dateToShow: formatedDateToShow,
      readingTimeText:
          readingTime(newsTitle + newsContent + newsDescription).msg,
    );
  }

  //* we need news as list
  static List<NewsModel> newsFromSnapshot(List newsSnaphot) {
    return newsSnaphot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
  }

}
