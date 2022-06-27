import 'package:flutter/material.dart';

import '../style_guide.dart';

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
      child: Text("Scroller",style:testLargeFont),
    );
  }
}
