import 'package:flutter/material.dart';
import 'package:machinetest/pages/category.dart';
import 'package:machinetest/pages/home.dart';
import 'package:machinetest/pages/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<BottomMenu> _menu = [
    BottomMenu(title: 'Home', icon: Icons.home),
    BottomMenu(title: 'Category', icon: Icons.category_outlined),
    BottomMenu(title: 'Profile', icon: Icons.settings),
  ];

  final List<Widget> _pages = const [HomePage(), ProductCategory(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _menu
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.title,
              ),
            )
            .toList(),
      ),
    );
  }
}

class BottomMenu {
  final String title;
  final IconData icon;

  BottomMenu({required this.title, required this.icon});
}
