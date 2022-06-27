import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestsScreen extends StatelessWidget {
  static const String routeName = '/TestsScreen';
  const TestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tests"),
      ),
      body: ListView(

        children: [
          ListTile(
            title: const Text("Sign Out"),
            onTap: (){
              _signOut();

            }
          ),
          ListTile(
              title: const Text("Provider Test"),
              onTap: (){
                Navigator.of(context).pushNamed('/ProviderTestScreen');
              }
          ),
          ListTile(
            title: const Text("Yet Another Test"),
            onTap: (){},
          ),
          ListTile(
            title: const Text("Yet Another Test"),
            onTap: (){},
          ),
          ListTile(
            title: const Text("Yet Another Test"),
            onTap: (){},
          )
        ],
      ),
    );
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();

}