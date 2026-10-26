import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import '../../screens/crud_screen.dart';
import '../../screens/profile_screen.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

    @override
  State<MainNavigation> createState() => _MainNavigationState();
}


class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
      DashboardScreen(),
      CrudScreen(),
      ProfileScreen(),
  ];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Kelola Data'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
