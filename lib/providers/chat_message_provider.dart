import 'package:flutter/cupertino.dart';

class ChatMessage with ChangeNotifier{
  final String contentString;
  final bool isSender;
  final String attachedFilePath;

  ChatMessage({
    required this.contentString,
    required this.isSender,
    required this.attachedFilePath
  });

}