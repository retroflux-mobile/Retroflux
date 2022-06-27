import 'package:flutter/material.dart';
import 'test_img.dart';

class TestImgs with ChangeNotifier{
  final List<TestImg> _loadedImgs = [
    TestImg(name: 'cat', link: "https://source.unsplash.com/gKXKBY-C-Dk", genre: "animal"),
    TestImg(name: 'tokyo', link: "https://source.unsplash.com/IocJwyqRv3M", genre: "city"),
    TestImg(name: 'udon', link: "https://source.unsplash.com/HuO_YvgEPtM", genre: "food"),
    TestImg(name: 'civic', link: "https://source.unsplash.com/DuIJri27XuQ", genre: "car")
  ];

  List<TestImg> get loadedImgs{
    return [..._loadedImgs];
  }

  void addImg(){
    //_imgs.add(value);
    notifyListeners();
  }

  TestImg findByName(String name){
    return _loadedImgs.firstWhere((element) => element.name==name);
  }
}