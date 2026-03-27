import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

import '../models/news_model.dart';
import '../providers/news_provider.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final isSaved = provider.isBookmarked(news.url);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1A18),
      body: Stack(
        children: [
          Image.network(
            news.image,
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: () => Share.share(news.url),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.6,
            builder: (_, controller) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF122420),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "${news.source} • ${formatDate(news.publishedAt)}",
                        style: TextStyle(color: Colors.white60),
                      ),

                      SizedBox(height: 20),

                      Text(
                        news.description,
                        style: TextStyle(color: Colors.white70),
                      ),

                      SizedBox(height: 30),

                      GestureDetector(
                        onTap: () {
                          provider.toggleBookmark(news);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isSaved
                                  ? [Colors.red, Colors.orange]
                                  : [Color(0xFF2F6F63), Color(0xFFA7C9B9)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              isSaved ? "Bookmarked ✓" : "Bookmark",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String formatDate(String date) {
    try {
      return DateFormat('dd MMM, hh:mm a').format(DateTime.parse(date));
    } catch (e) {
      return '';
    }
  }
}
