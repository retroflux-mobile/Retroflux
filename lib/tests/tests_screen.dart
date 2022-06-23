import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retroflux/screens/login_method_screen.dart';

class TestsScreen extends StatelessWidget {
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginMethodScreen()));
            }
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