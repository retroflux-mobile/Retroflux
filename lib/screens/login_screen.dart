import 'package:flutter/material.dart';
import 'package:retroflux/screens/homepage_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Log in with Google Account")
      ),
      body: Center(
        //Todo: Apply Firebase Authentication
        child: TextButton(
          onPressed: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePageScreen()));
          },
          child: const Text("Sneak in"),
        )
      ),
    );
  }
}
