import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:retroflux/models/pdf_info.dart';

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

  void addPdfInfo(PdfInfo pdfInfo) {
    _pdfList.insert(0, pdfInfo);
    notifyListeners();
  }

  Future<void> initPDFMessages() async {
    Directory fileDir = await getApplicationDocumentsDirectory();
    String cachePath = fileDir.path;
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
