import 'package:flutter/material.dart';
import 'package:retroflux/style_guide.dart';

class AddPageScreen extends StatefulWidget {
  const AddPageScreen({Key? key}) : super(key: key);

  @override
  State<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Add Page",style: testLargeFont,),
    );
  }
}
