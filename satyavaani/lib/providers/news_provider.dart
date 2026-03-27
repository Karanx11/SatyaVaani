import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/news_model.dart';
import '../services/api_service.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final box = Hive.box('bookmarks');

  List<NewsModel> _news = [];
  bool _isLoading = false;

  String _language = "en";
  String _city = "Lucknow";
  String _category = "";

  List<NewsModel> get news => _news;
  bool get isLoading => _isLoading;
  String get language => _language;
  String get city => _city;
  String get category => _category;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      _news = await _apiService.fetchNews(
        city: _category.isEmpty ? _city : null,
        category: _category.isNotEmpty ? _category : null,
        lang: _language,
      );
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeCategory(String category) {
    _category = category;
    fetchNews();
  }

  void changeLanguage(String lang) {
    _language = lang;
    fetchNews();
  }

  void changeCity(String city) {
    _city = city;
    _category = ""; // reset category
    fetchNews();
  }

  /// 🔖 BOOKMARK
  void toggleBookmark(NewsModel news) {
    if (box.containsKey(news.url)) {
      box.delete(news.url);
    } else {
      box.put(news.url, news.title);
    }
    notifyListeners();
  }

  bool isBookmarked(String url) {
    return box.containsKey(url);
  }
}
