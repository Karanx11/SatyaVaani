import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('bookmarks');

    return Scaffold(
      appBar: AppBar(title: Text("Bookmarks")),
      body: box.isEmpty
          ? Center(child: Text("No bookmarks yet"))
          : ListView(
              children: box.keys.map((key) {
                return ListTile(
                  title: Text(
                    box.get(key),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
