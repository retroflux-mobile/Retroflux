import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:retroflux/firebase_options.dart';
import 'package:retroflux/screens/homepage_screen.dart';

class LoginMethodScreen extends StatelessWidget {
  const LoginMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 40),
                child: Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.blue,
                  size: constraints.maxWidth / 4 * (1 - shrinkOffset),
                ),
              );
            },
              providerConfigs: const [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId: googleWbeID,
                ),
              ]
          );
        }
        // Render your application if authenticated
        return const HomePageScreen();
      },
    );
  }
}