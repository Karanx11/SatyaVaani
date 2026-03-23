import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/news_model.dart';

class NewsService {
  final supabase = Supabase.instance.client;

  Future<List<NewsModel>> fetchNews(String region) async {
    final response = await supabase.from('news').select().inFilter('region', [
      region,
      'global',
    ]); // 🔥 important improvement

    // 🔍 DEBUG LOGS
    print("REGION: $region");
    print("DATA: $response");

    final List data = response as List;

    return data.map((item) => NewsModel.fromMap(item)).toList();
  }
}
