import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retroflux/providers/chat_message_provider.dart';


class Chat with ChangeNotifier{
  List<ChatMessage> _loadedMessages=[];
  bool initialized = false;

  List<ChatMessage> get loadedMessages{
    return [..._loadedMessages];
  }

  void setMsg(List<ChatMessage> msgLst){
    _loadedMessages = msgLst;
    notifyListeners();
  }

  Future<void> addMsg(ChatMessage item) async {
    _loadedMessages.add(item);
    await saveToJson();
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> messages = [];
    for(ChatMessage msg in _loadedMessages){
      messages.add({
        "contentString":msg.contentString,
        "isSender":msg.isSender,
        "attachedFilePath":msg.attachedFilePath
      });
    }
    return {
      "messages":messages
    };
  }

  Future<void> getChatMessages() async {
    //Get chat json file directory
    Directory fileDir = await getApplicationDocumentsDirectory();
    String filePath = fileDir.path;
    List<ChatMessage> messages = [];
    bool chatJsonexist = await File("$filePath/chat_messages.json").exists();

    //load sample chat
    //String sampleChat = await rootBundle.loadString("assets/sample_chat_messages.json");
    //await File("$filePath/chat_messages.json").writeAsString(sampleChat);

    // if chat data already initialized, do nothing
    if(initialized){
    }else{
      //else, check if chat data json file exist.Load if exist, create one if not.
      if(chatJsonexist){
      final file = await File("$filePath/chat_messages.json").readAsString();
      final json = await jsonDecode(file);
      for(Map<String, dynamic> messageJson in json["messages"]){
        messages.add(
            ChatMessage(
                contentString: messageJson["contentString"],
                isSender: messageJson["isSender"],
                attachedFilePath: messageJson["attachedFilePath"]
            )
        );
      }
    }else{
        await File("$filePath/chat_messages.json").create();
      }
      setMsg(messages);
      initialized = true;
    }
  }

  Future<void> saveToJson() async {
    Directory fileDir = await getApplicationDocumentsDirectory();
    String filePath = fileDir.path;
    File file = await File("$filePath/chat_messages.json");
    await file.writeAsString(jsonEncode(toJson()));
    int length = jsonDecode(await File("$filePath/chat_messages.json").readAsString())["messages"].length;
    print(jsonDecode(await File("$filePath/chat_messages.json").readAsString())["messages"][length-1]);

  }
}