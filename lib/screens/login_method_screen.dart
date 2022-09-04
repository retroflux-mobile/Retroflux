import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:retroflux/firebase_options.dart';
import 'package:retroflux/screens/homepage_screen.dart';
import 'package:retroflux/screens/signup_swipe_screen.dart';

class LoginMethodScreen extends StatelessWidget {
  static const String routeName = '/login_method';

  const LoginMethodScreen({Key? key}) : super(key: key);

  Future<bool> checkIfNewUser(User currentUser) async {
    final userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .get();
    return false;
  }

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
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      "assets/rficon.png",
                    ),
                  ),
                );
              },
              providerConfigs: const [
                EmailProviderConfiguration(),
                // GoogleProviderConfiguration(
                //   clientId: googleWebID,
                // ),
              ]);
        } else {
            return HomePageScreen();
          // FutureBuilder(
          //     future: checkIfNewUser(snapshot.data!),
          //     builder: (context, boolSnapshot) {
          //       if (boolSnapshot.connectionState == ConnectionState.done) {
          //         bool checkNew = boolSnapshot.data! as bool;
          //         return checkNew
          //             ? const SignUpSwipeScreen()
          //             : const HomePageScreen();
          //       } else {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //     });
        }
      },
    );
  }
}
