import 'package:flutter/material.dart';

import '../style_guide.dart';

class NotehubScreen extends StatefulWidget {
  const NotehubScreen({Key? key}) : super(key: key);

  @override
  State<NotehubScreen> createState() => _NotehubScreenState();
}

class _NotehubScreenState extends State<NotehubScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Notehub",style:testLargeFont),
    );
  }
}
