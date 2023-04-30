import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/router/router.gr.dart';

class NavigationPages extends StatefulWidget {
  const NavigationPages({super.key});

  @override
  State<NavigationPages> createState() => _NavigationPagesState();
}

class _NavigationPagesState extends State<NavigationPages> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) => AppBar(
        title: const Text('Hotel'),
        centerTitle: true,
        leading: const AutoLeadingButton(),
      ),
      routes: const [
        Home(),
        Profile(),
        Settings(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return SalomonBottomBar(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        );
      },
    );
  }
}

// Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel Booking App'),
//       ),
//       bottomNavigationBar: Container(
//         color: Theme.of(context).colorScheme.onPrimary,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 12,
//           ),
//           child: GNav(
//             backgroundColor: Theme.of(context).colorScheme.onPrimary,
//             activeColor: Theme.of(context).colorScheme.primary,
//             padding: const EdgeInsets.all(15),
//             gap: 5,
//             selectedIndex: index,
//             onTabChange: (value) {
//               setState(() {
//                 index = value;
//               });
//             },
//             tabs: [
//               GButton(
//                 icon: index == 0 ? Icons.home : Icons.home_outlined,
//                 text: 'Home',
//               ),
//               GButton(
//                 icon: index == 1 ? Icons.person : Icons.person_outlined,
//                 text: 'Profile',
//               ),
//               GButton(
//                 icon: index == 2 ? Icons.settings : Icons.settings_outlined,
//                 text: 'Settings',
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         bottom: true,
//         child: _screens[index],
//       ),
//     );