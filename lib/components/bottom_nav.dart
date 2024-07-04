import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<String> _route = ['/home', '/req', '/sell'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacementNamed(context, _route[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.red, // Change this to your desired color
      unselectedItemColor: Colors.grey, // Change this to your desired color
      selectedIconTheme: IconThemeData(
          color: Colors.red), // Change this to your desired color
      unselectedIconTheme: IconThemeData(
          color: Colors.grey), // Change this to your desired color
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sell),
          label: "Sell",
        ),
      ],
    );
  }
}
