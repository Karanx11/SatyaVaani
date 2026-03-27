import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';
import '../widgets/shimmer_loader.dart';
import '../widgets/category_selector.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("SatyaVaani"),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              provider.changeLanguage(provider.language == "en" ? "hi" : "en");
            },
          ),
        ],
      ),
      body: provider.isLoading
          ? ShimmerLoader()
          : Column(
              children: [
                CategorySelector(),

                Expanded(
                  child: provider.news.isEmpty
                      ? Center(
                          child: Text(
                            "No news found",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.news.length,
                          itemBuilder: (_, i) =>
                              NewsCard(news: provider.news[i]),
                        ),
                ),
              ],
            ),
    );
  }
}
