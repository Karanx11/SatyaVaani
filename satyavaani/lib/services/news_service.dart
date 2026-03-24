import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/news_model.dart';

class NewsService {
  final supabase = Supabase.instance.client;

  Future<List<NewsModel>> fetchNews(String region) async {
    try {
      final response = await supabase
          .from('news')
          .select()
          .inFilter('region', [region, 'global']) // 🌍 region + global
          .order('created_at', ascending: false) // 🔥 latest first
          .limit(50); // 🔥 limit for performance

      // 🔍 DEBUG
      print("REGION: $region");
      print("TOTAL FETCHED: ${response.length}");
      print("DATA: $response");

      final List<dynamic> data = response;

      return data.map((item) => NewsModel.fromMap(item)).toList();
    } catch (e) {
      print("❌ Error fetching news: $e");
      return [];
    }
  }
}
