import 'package:flutter/material.dart';
import 'package:nextintern_mobile/consts/global_colors.dart';
import 'package:nextintern_mobile/screens/home_screen.dart';
import 'package:nextintern_mobile/screens/profile_screen.dart';
import 'package:nextintern_mobile/screens/question_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const QuestionScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Question',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.profile),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: lightIconsColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
