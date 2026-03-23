class NewsModel {
  final String videoUrl;
  final String headline;
  final String source;
  final String caption;
  final bool isVerified;
  final String region;
  final String category;

  NewsModel({
    required this.videoUrl,
    required this.headline,
    required this.source,
    required this.caption,
    required this.isVerified,
    required this.region,
    required this.category,
  });

  factory NewsModel.fromMap(Map<String, dynamic> data) {
    return NewsModel(
      videoUrl: data['video_url'] ?? '', // ✅ FIXED
      headline: data['headline'] ?? '',
      source: data['source'] ?? '',
      caption: data['caption'] ?? '',
      isVerified: data['is_verified'] ?? false, // ✅ FIXED
      region: data['region'] ?? 'india',
      category: data['category'] ?? 'national',
    );
  }
}
