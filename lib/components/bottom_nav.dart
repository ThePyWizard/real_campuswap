import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    const route=[ '/home','/chat','/sell'
      
    ];

    return  BottomNavigationBar(
        onTap: (value) => Navigator.pushReplacementNamed(context, route[value]),
        items: [BottomNavigationBarItem(icon: Icon(Icons.home)),BottomNavigationBarItem(icon: Icon(Icons.chat)),BottomNavigationBarItem(icon: Icon(Icons.baby_changing_station)),],
      );
  }
}