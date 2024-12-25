import 'package:doctorapp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create a Persistent Tab Controller
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    // Define your screens
    List<Widget> _screens = [
      HomePage(),
      HomePage(),
      HomePage(),
      HomePage(),
    ];

    // Define your bottom navigation bar items
    List<PersistentBottomNavBarItem> _navBarItems = [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notifications"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: const Color.fromARGB(255, 33, 33, 33),
      ),
    ];

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarItems,

      navBarStyle: NavBarStyle.style6, // Ensure the style matches your needs
      navBarHeight: 45.0, // Height of the bottom navigation bar
      backgroundColor: Colors.white, // Background color of the bottom nav
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      bottomScreenMargin: 5,
      confineToSafeArea: true,
      onItemSelected: (index) {
        // Handle item selection if needed
        print("Selected Tab: $index");
      },
    );
  }
}
