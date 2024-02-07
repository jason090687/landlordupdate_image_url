import 'package:flutter/material.dart';
import 'package:tanle/nav_pages/Booking_nav.dart';
import 'package:tanle/nav_pages/chats_nav.dart';
import 'package:tanle/nav_pages/favorites_nav.dart';
import 'package:tanle/nav_pages/home_page.dart';
import 'package:tanle/nav_pages/profile_page.dart';

class NavBarPages extends StatefulWidget {
  const NavBarPages({super.key});

  @override
  State<NavBarPages> createState() => _NavBarPagesState();
}

class _NavBarPagesState extends State<NavBarPages> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const FavoritePage(),
    const MyBookingScreen(),
    const ChatApp(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_sharp), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
