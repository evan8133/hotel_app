import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../home/page/home_screen.dart';
import '../profile/page/profile_screen.dart';
import '../setting/page/settings_screen.dart';

class NavigationPages extends StatefulWidget {
  const NavigationPages({super.key});

  @override
  State<NavigationPages> createState() => _NavigationPagesState();
}

class _NavigationPagesState extends State<NavigationPages> {
  int index = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking App'),
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        activeColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(15),
        gap: 5,
        selectedIndex: index,
        onTabChange: (value) {
          setState(() {
            index = value;
          });
        },
        tabs: [
          GButton(
            icon: index == 0 ? Icons.home : Icons.home_outlined,
            text: 'Home',
          ),
          GButton(
            icon: index == 1 ? Icons.person : Icons.person_outlined,
            text: 'Profile',
          ),
          GButton(
            icon: index == 2 ? Icons.settings : Icons.settings_outlined,
            text: 'Settings',
          ),
        ],
      ),
      body: _screens[index],
    );
  }
}
