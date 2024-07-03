import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    const route=[ '/home','/req','/sell'
      
    ];

    return  BottomNavigationBar(
        onTap: (value) => Navigator.pushReplacementNamed(context, route[value]),
        items: [BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Home"),BottomNavigationBarItem(icon: Icon(Icons.baby_changing_station),label: "Home"),],
      );
  }
}