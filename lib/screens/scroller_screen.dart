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
    return const Center(
        child: Scroller(
      images: <Image>[
        Image(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
        ),
        Image(
          image: NetworkImage(
              'https://flxt.tmsimg.com/assets/p12991665_b_v13_am.jpg'),
        ),
        Image(
          image: NetworkImage(
              'https://flxt.tmsimg.com/assets/p12991665_b_v13_am.jpg'),
        ),
      ],
    ));
  }
}
