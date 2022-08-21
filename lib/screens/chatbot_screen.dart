import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/chat_message_provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_message_item.dart';


class ChatbotScreen extends StatefulWidget {
  static const String routeName = '/chatbot';
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool initialed = false;
  final ScrollController _controller = ScrollController();
  TextEditingController _chatInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messageData = Provider.of<Chat>(context);
    return FutureBuilder(
        future: messageData.getChatMessages(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          List<ChatMessage> messages = messageData.loadedMessages;
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: messages.length,
                      controller: _controller,
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: messages[i],
                        child: chatMessageItem(message: messages[i]),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: _chatInputController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Say something :D',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          messageData
                              .addMsg(ChatMessage(
                                  contentString: _chatInputController.text,
                                  isSender: true,
                                  attachedFilePath: ""))
                              .then((_) {
                            _controller.animateTo(
                                _controller.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 1),
                                curve: Curves.ease);
                          });
                        },
                        icon: Icon(Icons.send))
                  ],
                )
              ],
            ),
          );
        });
  }
}
