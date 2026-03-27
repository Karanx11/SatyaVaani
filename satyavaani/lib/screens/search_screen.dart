import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  void search() {
    Provider.of<NewsProvider>(
      context,
      listen: false,
    ).changeCity(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Search News")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search by city or keyword...",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.news.length,
                    itemBuilder: (_, i) => NewsCard(news: provider.news[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
