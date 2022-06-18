import 'package:flutter/material.dart';
import 'package:retroflux/screens/login_screen.dart';
import 'package:retroflux/style_guide.dart';

class LoginMethodScreen extends StatelessWidget {
  const LoginMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("RetroFlux",style: testLargeFont,),
            SizedBox(
              height: MediaQuery.of(context).size.height/3,
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: const Text("Log in with Google Account")
            ),
            TextButton(
                onPressed: (){},
                child: const Text("Log in with XX")
            ),
            TextButton(
                onPressed: (){},
                child: const Text("Log in with XX")
            )
          ],
        ),
      ),
    );
  }
}
