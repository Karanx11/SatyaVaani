import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class CategorySelector extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Top", "value": "", "image": "assets/images/general.jpg"},
    {"name": "Tech", "value": "technology", "image": "assets/images/tech.jpg"},
    {
      "name": "Business",
      "value": "business",
      "image": "assets/images/business.jpg",
    },
    {"name": "Sports", "value": "sports", "image": "assets/images/sports.jpg"},
    {
      "name": "Politics",
      "value": "nation",
      "image": "assets/images/politics.jpg",
    },
    {
      "name": "Entertainment",
      "value": "entertainment",
      "image": "assets/images/entertainment.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final cat = categories[index];
          final isSelected = provider.category == cat['value'];

          return GestureDetector(
            onTap: () => provider.changeCategory(cat['value']),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(right: 14),
              width: isSelected ? 100 : 85,
              child: Column(
                children: [
                  /// 🔥 IMAGE CIRCLE
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isSelected ? 85 : 75,
                    width: isSelected ? 85 : 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [Color(0xFF2F6F63), Color(0xFFA7C9B9)],
                            )
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipOval(
                        child: Stack(
                          children: [
                            /// IMAGE
                            Positioned.fill(
                              child: Image.asset(
                                cat['image'],
                                fit: BoxFit.cover,
                              ),
                            ),

                            /// DARK OVERLAY
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.35),
                              ),
                            ),

                            /// GLASS EFFECT
                            if (isSelected)
                              Positioned.fill(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 6,
                                    sigmaY: 6,
                                  ),
                                  child: Container(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  /// TEXT
                  Text(
                    cat['name'],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Color(0xFFA7C9B9) : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
