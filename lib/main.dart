import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/test_img_provider.dart';
import 'package:retroflux/screens/homepage_screen.dart';
import 'package:retroflux/screens/login_method_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:retroflux/tests/provider_test_screen.dart';
import 'package:retroflux/tests/tests_screen.dart';
import 'firebase_options.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (BuildContext context) => TestImgs(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: const LoginMethodScreen(),
        routes: {
          '/LoginMethodScreen':(ctx)=>const LoginMethodScreen(),
          '/HomePageScreen':(ctx)=> const HomePageScreen(),
          '/TestsScreen':(ctx)=> const TestsScreen(),
          '/ProviderTestScreen':(ctx)=>const ProviderTestScreen(),
        },
      ),
    );
  }
}
