import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:retroflux/models/pdf_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PdfProvider with ChangeNotifier {
  final List<PdfInfo> _pdfList = [
    PdfInfo(
        path:
            'https://firebasestorage.googleapis.com/v0/b/retroflux-cf1ae.appspot.com/o/ch1.pdf?alt=media&token=87ae4400-08fb-42d4-bbe8-803329da6003',
        favoritePages: [1, 3, 5]),
    PdfInfo(
        path:
            'https://firebasestorage.googleapis.com/v0/b/retroflux-cf1ae.appspot.com/o/ch1.pdf?alt=media&token=87ae4400-08fb-42d4-bbe8-803329da6003',
        favoritePages: [1, 3, 5]),
  ];

  List<PdfInfo> get loadedPdfs {
    return [..._pdfList];
  }


  Future<bool> checkRankUpdate() async {
    //Check the "feedUpdated" field of user's doc, if true, call rerank function
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    bool updated =  await FirebaseFirestore.instance.collection("Users").doc(uid)
        .get().then((data) {
         return data["feedUpdated"];
    });
    print("feedUpdate: "+updated.toString());
    return updated;
  }


  Future<void> rerank() async {
    //clear all pdf files in scroller and rebuild the list based on the feedRank in user's doc
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    List<dynamic> newRank = await FirebaseFirestore.instance.collection("Users").doc(uid)
        .get().then((data) {
      return data["feedRank"];
    });
    List<String> newFeedFiles = List<String>.from(newRank);
    print("getting new file links");
    _pdfList.clear();
    for(String filePath in newFeedFiles){
      String fileLink = await getDownloadLinkFromPath(filePath);
      _pdfList.add(PdfInfo(path: fileLink,favoritePages: []));
      print("one file added to feed");
    }
    notifyListeners();
  }

  Future<String> getDownloadLinkFromPath(String pdfPath) async {
    //get a file's download link from its path in firebase
    String downloadLink = await FirebaseFirestore.instance.doc(pdfPath).get().then((value) => value["file_url"]);
    return downloadLink;
  }


  void addPdfInfo(PdfInfo pdfInfo) {
    _pdfList.insert(0, pdfInfo);
    notifyListeners();
  }

  Future<void> initPDFMessages() async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    Directory fileDir = await getApplicationDocumentsDirectory();
    String cachePath = fileDir.path;
    bool neeedToUpdate = await checkRankUpdate();
    if(neeedToUpdate){
      await FirebaseFirestore.instance.collection("Users").doc(uid)
          .update({"feedUpdated":false});
      rerank();
    };

    for (var i = 0; i < _pdfList.length; i++) {
      // '?' not allowed in file system
      String filename =
          _pdfList[i].path.substring(74).replaceAll('?', '_') + '.pdf';
      String fullPath = cachePath + filename;
      if (!File(fullPath).existsSync()) {
        var data = await http.get(Uri.parse(_pdfList[i].path));
        var bytes = data.bodyBytes;
        await File(fullPath).writeAsBytes(bytes);
      }
      _pdfList[i].localPath = fullPath;
    }
  }
}
