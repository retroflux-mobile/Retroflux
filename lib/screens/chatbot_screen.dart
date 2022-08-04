import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/chat_message_provider.dart';
import '../providers/chat_provider.dart';

class ChatbotScreen extends StatefulWidget {
  static const String routeName = '/chatbot';
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  @override
  Widget build(BuildContext context) {
    final messageData = Provider.of<Chat>(context);
    return FutureBuilder(
      future: getChatMessages(messageData),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        List<ChatMessage> messages = messageData.loadedMessages;
        return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10,20,10,10),
                child: Text(
                  messages[index].contentString,
                  textAlign: messages[index].isSender?TextAlign.end:TextAlign.start,
                ),
              );
            });
      }
    );
  }
}

Future<void> getChatMessages(Chat chatClass) async {
  final file = await rootBundle.loadString("assets/chat_messages.json");
  final json = await jsonDecode(file);
  List<ChatMessage> messages = [];
  for(Map<String, dynamic> messageJson in json["messages"]){
    messages.add(
        ChatMessage(
            contentString: messageJson["contentString"],
            isSender: messageJson["isSender"],
            attachedFilePath: messageJson["attachedFilePath"]
        )
    );
  }
  chatClass.setMsg(messages);
}