import 'package:bfg/screens/bfg/bfg_home.dart';
import 'package:bfg/screens/cabpools/pool_home.dart';
import 'package:bfg/screens/user/profile.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final List<Widget> _pages = [
    const Profile(),
    const BfgHome(),
    const PoolHome(),
  ];
  int _selectedIndex = 1;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OurTheme _theme = OurTheme();
    return SafeArea(
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: _theme.secondaryColor,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.linear);
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: _theme.primaryColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark_outline_rounded,
                    ),
                    label: "Books"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.directions_car,
                    ),
                    label: "Pool"),
              ],
              iconSize: 25.0,
              unselectedFontSize: 12.0,
              selectedFontSize: 12.0,
              selectedItemColor: _theme.secondaryColor,
              unselectedItemColor: Colors.white,
            ),
          ),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
