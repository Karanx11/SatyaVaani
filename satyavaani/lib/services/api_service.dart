import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class ApiService {
  static const String apiKey = "a77c6b99b20e958cdaba59b7a13e3878";

  Future<List<NewsModel>> fetchNews({
    String? city,
    String? category,
    String lang = 'en',
  }) async {
    String url;

    if (city != null && city.isNotEmpty) {
      url =
          "https://gnews.io/api/v4/search?q=$city&lang=$lang&token=YOUR_API_KEY";
    } else if (category != null && category.isNotEmpty) {
      url =
          "https://gnews.io/api/v4/top-headlines?category=$category&lang=$lang&country=in&token=YOUR_API_KEY";
    } else {
      url =
          "https://gnews.io/api/v4/top-headlines?lang=$lang&country=in&token=YOUR_API_KEY";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();
    } else {
      throw Exception("API FAILED");
    }
  }
}
