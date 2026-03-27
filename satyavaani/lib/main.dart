import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'providers/news_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('bookmarks');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsProvider())],
      child: SatyaVaaniApp(),
    ),
  );
}
