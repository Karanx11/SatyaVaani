import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print("ENV: ${dotenv.env}");
  print("URL: ${dotenv.env['SUPABASE_URL']}");

  // ✅ Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const SatyaVaaniApp());
}

class SatyaVaaniApp extends StatefulWidget {
  const SatyaVaaniApp({super.key});

  @override
  State<SatyaVaaniApp> createState() => _SatyaVaaniAppState();
}

class _SatyaVaaniAppState extends State<SatyaVaaniApp> {
  bool isDark = true;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SatyaVaani",
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: HomeScreen(toggleTheme: toggleTheme, isDark: isDark),
    );
  }
}
