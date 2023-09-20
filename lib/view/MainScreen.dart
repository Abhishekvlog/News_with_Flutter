import 'package:api_calling/view/home_screen.dart';
import 'package:api_calling/view/news_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _current_poss = 0;

  final List<Widget> _screen =[
    NewsScreen(),
    SearchScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_current_poss],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current_poss,
        onTap: (index){
          setState(() {
            _current_poss = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "search")

        ],
      ),
    );
  }
}
