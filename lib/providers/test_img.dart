import 'package:flutter/cupertino.dart';

class TestImg with ChangeNotifier{
  final String name;
  final String link;
  final String genre;
  bool isLiked;

  TestImg({
    required this.name,
    required this.link,
    required this.genre,
    this.isLiked=false});

  void clickLike(){
    isLiked = !isLiked;
    notifyListeners();
  }
}