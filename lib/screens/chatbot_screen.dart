import 'package:flutter/material.dart';
import 'package:retroflux/style_guide.dart';

class ChatbotScreen extends StatefulWidget {
  static const String routeName = '/chatbot';
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Chatbot",style: testLargeFont,),
    );
  }
}
