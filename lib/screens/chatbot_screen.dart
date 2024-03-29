import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/chat_message_provider.dart';
import '../models/pdf_info.dart';
import '../providers/chat_provider.dart';
import '../providers/pdf_provider.dart';
import 'homepage_screen.dart';

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
  String currentUID = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final messageData = Provider.of<Chat>(context);
    return FutureBuilder(
        future: messageData.getChatMessages(currentUID),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          List<ChatMessage> messages = messageData.loadedMessages;
          messages = List<ChatMessage>.from(messages.reversed);
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black87
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.smart_toy, color: Colors.white,size: 50,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("  ChatBot",style: TextStyle(color: Colors.white,fontSize:30,fontWeight: FontWeight.bold),),
                      )
                    ],
                  )
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(55)
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.846,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            controller: _controller,
                            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: messages[i],
                              child: chatMessageItem(message: messages[i]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: DecoratedBox(
                                  decoration:BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: TextField(
                                    controller: _chatInputController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color: Colors.black87)
                                      ),
                                      hintText: 'Say something :D',
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                color: Colors.white,
                                  onPressed: () async {
                                    await messageData.addMsg(
                                        ChatMessage(
                                            contentString: _chatInputController.text,
                                            isSender: true,
                                            attachedFilePath: ""),
                                        currentUID);
                                    _controller.animateTo(
                                      0,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.easeInOutCubic,
                                    );
                                    _chatInputController.clear();
                                  },
                                  icon: Icon(Icons.send))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class chatMessageItem extends StatelessWidget {
  const chatMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final pdfListData = Provider.of<PdfProvider>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
      alignment: message.isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: message.isSender ? Colors.grey : Colors.orange,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            message.contentString == "LOADING"
                ? LoadingAnimationWidget.stretchedDots(
                    color: Colors.white, size: 30)
                : Text(
                    message.contentString,
                  ),
            message.attachedFilePath == ""
                ? SizedBox()
                : IconButton(
                    onPressed: () async {
                      pdfListData.addPdfInfo(PdfInfo(
                          path: message.attachedFilePath, favoritePages: [1]));
                      Navigator.pushReplacementNamed(
                          context, HomePageScreen.routeName);
                    },
                    icon: Icon(
                      Icons.description,
                      size: 50,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
