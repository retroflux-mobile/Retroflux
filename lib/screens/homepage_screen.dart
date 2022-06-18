import 'package:flutter/material.dart';
import 'package:retroflux/screens/addpage_screen.dart';
import 'package:retroflux/screens/chatbot_screen.dart';
import 'package:retroflux/screens/notehub_screen.dart';
import 'package:retroflux/screens/profile_screen.dart';
import 'package:retroflux/screens/scroller_screen.dart';

import '../style_guide.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final List<Widget> _bottomNavBarTabs = const [
    ScrollerScreen(),
    NotehubScreen(),
    AddPageScreen(),
    ChatbotScreen(),
    ProfileScreen()
  ];

  int _bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavBarTabs.elementAt(_bottomNavBarIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavBarIndex,
        iconSize: 42.0,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            //Todo: New name for Scroller Screen
            label: 'Scroller',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Notehub',
          ),
          BottomNavigationBarItem(
            //Todo: Customize add button
            icon: Icon(Icons.add_circle_outlined,size: 60,),
            label:"",
            backgroundColor: Colors.amberAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Chat Bot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Profile',
          ),
        ],
        selectedItemColor: selectedIconColor,
        unselectedItemColor: unSelectedIconColor,
        onTap: (index){
          setState(() {
            _bottomNavBarIndex = index;
          });
        },
      ),
    );
  }
}