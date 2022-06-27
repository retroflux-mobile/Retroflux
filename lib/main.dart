import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/test_img_provider.dart';
import 'package:retroflux/screens/addpage_screen.dart';
import 'package:retroflux/screens/chatbot_screen.dart';
import 'package:retroflux/screens/homepage_screen.dart';
import 'package:retroflux/screens/login_method_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:retroflux/screens/notehub_screen.dart';
import 'package:retroflux/screens/profile_screen.dart';
import 'package:retroflux/screens/scroller_screen.dart';
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
      create: (context)=> TestImgs(),
      child: MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: const LoginMethodScreen(),
        routes: {
          AddPageScreen.routeName: (context) => const AddPageScreen(),
          ChatbotScreen.routeName: (context) => const ChatbotScreen(),
          HomePageScreen.routeName: (context) => const HomePageScreen(),
          LoginMethodScreen.routeName: (context) => const LoginMethodScreen(),
          NotehubScreen.routeName: (context) => const NotehubScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          ScrollerScreen.routeName: (context) => const ScrollerScreen(),
          TestsScreen.routeName: (context) => const TestsScreen(),
          ProviderTestScreen.routeName:(context) => const ProviderTestScreen()
        },
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            // ScrollerScreen.routeName: (context) => ScrollerScreen(),
          };
          WidgetBuilder? builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder!(ctx));
        },
      ),
    );
  }
}
