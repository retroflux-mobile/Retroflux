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
            ElevatedButton(
              onPressed: () { },
              child: const Text("1"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
              ),
            ),
            ElevatedButton(
              onPressed: () { },
              child: const Text("2"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
            ElevatedButton(
              onPressed: () { },
              child: const Text("3"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
            )
          ],
          [
            Container(
              color: Colors.green,
              child: IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {},
              ),
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
