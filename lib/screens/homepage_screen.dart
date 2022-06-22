import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: _bottomNavBarIndex,
        activeColor: Colors.white,
        style: TabStyle.fixedCircle,
        items: const <TabItem>[
          TabItem(
            icon: Icon(Icons.star,color: Colors.white,),
            //Todo: New name for Scroller Screen
            title: 'Scroller',
          ),
          TabItem(
            icon: Icon(Icons.star,color: Colors.white,),
            title: 'Notehub',
          ),
          TabItem(
            icon: Icon(Icons.add,size:40,color: Colors.white,),
            title: 'Add',
          ),
          TabItem(
            icon: Icon(Icons.star,color: Colors.white,),
            title: 'ChatBot',
          ),
          TabItem(
            icon: Icon(Icons.star,color: Colors.white,),
            title: 'Profile',
          ),
        ],
        onTap: (index){
          setState(() {
            _bottomNavBarIndex = index;
          });
        },
      ),
    );
  }
}

