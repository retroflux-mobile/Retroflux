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

  TextEditingController _chatInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messageData = Provider.of<Chat>(context);
    return FutureBuilder(
      future: getChatMessages(messageData),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        List<ChatMessage> messages = messageData.loadedMessages;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatMessage message = messages[index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                      alignment: message.isSender?Alignment.topRight:Alignment.topLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width*0.6
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message.isSender?Colors.blueGrey:Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          message.contentString,
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child:TextField(
                      controller: _chatInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Say something :D',
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      messageData.addMsg(
                        ChatMessage(
                            contentString: _chatInputController.text,
                            isSender: true,
                            attachedFilePath: "")
                      );
                      print(messageData.loadedMessages.length);
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        );
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