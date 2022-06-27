import 'package:flutter/material.dart';
import 'package:retroflux/screens/addpage_screen.dart';
import 'package:retroflux/screens/chatbot_screen.dart';
import 'package:retroflux/screens/homepage_screen.dart';
import 'package:retroflux/screens/login_method_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:retroflux/screens/notehub_screen.dart';
import 'package:retroflux/screens/profile_screen.dart';
import 'package:retroflux/screens/scroller_screen.dart';
import 'package:retroflux/screens/tests_screen.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const LoginMethodScreen(),
      routes: {
        AddPageScreen.routeName: (context) => AddPageScreen(),
        ChatbotScreen.routeName: (context) => ChatbotScreen(),
        HomePageScreen.routeName: (context) => HomePageScreen(),
        LoginMethodScreen.routeName: (context) => LoginMethodScreen(),
        NotehubScreen.routeName: (context) => NotehubScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        ScrollerScreen.routeName: (context) => ScrollerScreen(),
        TestsScreen.routeName: (context) => TestsScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          // ScrollerScreen.routeName: (context) => ScrollerScreen(),
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
    );
  }
}
