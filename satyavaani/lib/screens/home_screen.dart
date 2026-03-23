import 'package:flutter/material.dart';
import 'news_screen.dart';
import 'entertainment_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // 🌍 REGION STATE
  String selectedRegion = "india";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDark ? Colors.black : Colors.white,

      /// 🔝 APP BAR
      appBar: AppBar(
        title: const Text(
          "SatyaVaani",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,

        actions: [
          /// 🌍 REGION SELECTOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedRegion,
                dropdownColor: widget.isDark ? Colors.black : Colors.white,
                icon: Icon(
                  Icons.public,
                  color: widget.isDark ? Colors.white : Colors.black,
                ),
                style: TextStyle(
                  color: widget.isDark ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
                items: const [
                  DropdownMenuItem(value: "india", child: Text("India 🇮🇳")),
                  DropdownMenuItem(value: "nepal", child: Text("Nepal 🇳🇵")),
                  DropdownMenuItem(value: "global", child: Text("Global 🌍")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRegion = value!;
                  });
                },
              ),
            ),
          ),

          /// 🌗 THEME TOGGLE
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              size: 26,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),

      /// 📱 BODY (PASS REGION HERE)
      body: currentIndex == 0
          ? NewsScreen(region: selectedRegion)
          : const EntertainmentScreen(),

      /// 🔻 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },

        backgroundColor: widget.isDark ? Colors.black : Colors.white,

        selectedItemColor: widget.isDark
            ? const Color(0xFF4D0000)
            : const Color(0xFF800000),

        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: "Entertainment",
          ),
        ],
      ),
    );
  }
}
