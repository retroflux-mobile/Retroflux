import 'package:flutter/material.dart';

import '../widgets/scroller.dart';

class ScrollerScreen extends StatefulWidget {
  static const String routeName = '/scroller';

  const ScrollerScreen({Key? key}) : super(key: key);

  @override
  State<ScrollerScreen> createState() => _ScrollerScreenState();
}

class _ScrollerScreenState extends State<ScrollerScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scroller(
        widgetList: [
          [
            const Image(
              image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
            const Image(
              image: NetworkImage('https://flxt.tmsimg.com/assets/p12991665_b_v13_am.jpg'),
            ),
            ElevatedButton(
              onPressed: () { },
              child: const Text("normal"),
            )
          ],
          [
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: "PWD",
                  hintText: "PWD",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),
          ]
        ]
      )
    );
  }
}
