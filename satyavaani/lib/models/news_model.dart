class NewsModel {
  final String title;
  final String description;
  final String image;
  final String source;
  final String publishedAt;
  final String url;

  NewsModel({
    required this.title,
    required this.description,
    required this.image,
    required this.source,
    required this.publishedAt,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      source: json['source']['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
