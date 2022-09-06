import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retroflux/providers/chat_message_provider.dart';

class Chat with ChangeNotifier {
  List<ChatMessage> _loadedMessages = [
  ];
  bool initialized = false;

  List<ChatMessage> get loadedMessages {
    return [..._loadedMessages];
  }

  void setMsg(List<ChatMessage> msgLst) {
    _loadedMessages = msgLst;
    notifyListeners();
  }

  Future<void> addMsg(ChatMessage item, String uid) async {

    _loadedMessages.add(item);
    addTempLoadingMessage();
    notifyListeners();

    await saveToJson();
    await messageBackend(item,uid);
  }

  void popTempMessage(){
    _loadedMessages.removeWhere((element) => element.contentString=="LOADING");
    notifyListeners();
  }

  void addTempLoadingMessage(){
    _loadedMessages.add(ChatMessage(contentString: "LOADING", isSender: false, attachedFilePath: ""));
    notifyListeners();
  }

  Future<void> messageBackend(ChatMessage item, String uid)async{
      Response response = await Dio().post('http://73.52.25.22:5000/api/chatbot', data: {'user_id':uid, 'message': item.contentString});
      List<dynamic> resDecode = response.data;
      for(dynamic i in resDecode){
        Map<String, dynamic> data = Map<String, dynamic>.from(i);
        if(data.keys.contains("text")){
          _loadedMessages.add(ChatMessage(contentString: data["text"], isSender: false, attachedFilePath: ""));
        }else{
          _loadedMessages.add(ChatMessage(contentString: "", isSender: false, attachedFilePath: i["attachment"]));
        }
      }
      popTempMessage();
      // _loadedMessages.add(
      //     ChatMessage(
      //         contentString: "Chatbot is still under tunning, but frontend is prepared. Click the icon to test viewing notes",
      //         isSender: false,
      //         attachedFilePath: "https://firebasestorage.googleapis.com/v0/b/retroflux-cf1ae.appspot.com/o/ch1Odd.pdf?alt=media&token=a4ac896e-5698-4cb6-8507-054acec3a430")
      // );
      notifyListeners();
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> messages = [];
    for (ChatMessage msg in _loadedMessages) {
      messages.add({
        "contentString": msg.contentString,
        "isSender": msg.isSender,
        "attachedFilePath": msg.attachedFilePath
      });
    }
    return {"messages": messages};
  }



  Future<void> getChatMessages(String uid) async {
    //Get chat json file directory
    Directory fileDir = await getApplicationDocumentsDirectory();
    String filePath = fileDir.path;
    List<ChatMessage> messages = [];
    bool chatJsonexist = await File("$filePath/chat_messages.json").exists();

    //load sample chat
    String sampleChat = await rootBundle.loadString("assets/sample_chat_messages.json");
    await File("$filePath/chat_messages.json").writeAsString(sampleChat);
    // if chat data already initialized, do nothing
    if (initialized) {
    } else {
      //else, check if chat data json file exist.Load if exist, create one if not.
      if (chatJsonexist) {
        final file = await File("$filePath/chat_messages.json").readAsString();
        final json = await jsonDecode(file);
        for (Map<String, dynamic> messageJson in json["messages"]) {
          messages.add(ChatMessage(
              contentString: messageJson["contentString"],
              isSender: messageJson["isSender"],
              attachedFilePath: messageJson["attachedFilePath"]));
        }
      } else {
        await File("$filePath/chat_messages.json").create();
      }
      setMsg(messages);
      initialized = true;
    }
  }

  Future<void> saveToJson() async {
    Directory fileDir = await getApplicationDocumentsDirectory();
    String filePath = fileDir.path;
    File file =  File("$filePath/chat_messages.json");
    await file.writeAsString(jsonEncode(toJson()));
  }
}
