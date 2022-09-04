import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:retroflux/screens/addpage_screen.dart';
import 'package:retroflux/screens/chatbot_screen.dart';
import 'package:retroflux/screens/notehub_screen.dart';
import 'package:retroflux/screens/profile_screen.dart';
import 'package:retroflux/screens/scroller_screen.dart';


class HomePageScreen extends StatefulWidget {
  static const String routeName = '/homepage';
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
        top: 0,
        initialActiveIndex: _bottomNavBarIndex,
        activeColor: Colors.orange,
        backgroundColor: Colors.black87,
        style: TabStyle.fixedCircle,
        items: const <TabItem>[
          TabItem(
            icon: Icon(Icons.home,color: Colors.white,),
            activeIcon:Icon(Icons.home,color: Colors.orange,),
            title: 'Scroller',
          ),
          TabItem(
            icon: Icon(Icons.menu_book,color: Colors.white,),
            activeIcon: Icon(Icons.menu_book,color: Colors.orange,),
            title: 'Notehub',
          ),
          TabItem(
            icon: Icon(Icons.add,size:40,color: Colors.white,),
            activeIcon: Icon(Icons.add,size:40,color: Colors.orange,),
            title: 'Add',
          ),
          TabItem(
            icon: Icon(Icons.chat,color: Colors.white,),
            activeIcon: Icon(Icons.chat,color: Colors.orange,),
            title: 'ChatBot',
          ),
          TabItem(
            icon: Icon(Icons.person,color: Colors.white,),
            activeIcon: Icon(Icons.person,color: Colors.orange,),
            title: 'Profile',
          ),
        ],
        onTap: (index){
          if(index!=2){
          setState(() {
            _bottomNavBarIndex = index;
          });}else{
            showAddDialog(context);
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.bug_report),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/TestsScreen');
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      resizeToAvoidBottomInset: false,
    );
  }
}


