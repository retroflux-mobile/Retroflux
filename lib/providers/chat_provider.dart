import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retroflux/providers/chat_message_provider.dart';


class Chat with ChangeNotifier{
  List<ChatMessage> _loadedMessages=[];

  List<ChatMessage> get loadedMessages{
    return [..._loadedMessages];
  }

  void setMsg(List<ChatMessage> msgLst){
    _loadedMessages = msgLst;
    notifyListeners();
  }

  void addMsg(ChatMessage item){
    _loadedMessages.add(item);
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


}