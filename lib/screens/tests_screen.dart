import 'package:flutter/material.dart';

class TestsScreen extends StatelessWidget {
  static const String routeName = '/tests';
  const TestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tests"),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: (){
            },
            child: const ListTile(
              title: Text("Firebase Uploading"),
            ),
          ),
          GestureDetector(
            onTap: (){
            },
            child: const ListTile(
              title: Text("yet another test"),
            ),
          ),
          GestureDetector(
            onTap: (){
            },
            child: const ListTile(
              title: Text("yet another test"),
            ),
          )
        ],
      ),
    );
  }
}
