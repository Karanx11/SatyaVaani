import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../widgets/video_card.dart';
import '../models/news_model.dart';

class NewsScreen extends StatefulWidget {
  final String region;

  const NewsScreen({super.key, required this.region});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final NewsService _service = NewsService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      key: ValueKey(widget.region),
      future: _service.fetchNews(widget.region),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No news available"));
        }

        final newsList = snapshot.data!;

        if (newsList.isEmpty) {
          return const Center(child: Text("No news available"));
        }

        return PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(), // 🔥 smooth feel
          itemCount: newsList.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final news = newsList[index];

            return Container(
              key: ValueKey(news.videoUrl + index.toString()), // 🔥 STRONG KEY
              child: VideoCard(news: news, isActive: index == currentIndex),
            );
          },
        );
      },
    );
  }
}
