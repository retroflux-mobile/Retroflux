import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:retroflux/models/pdf_info.dart';

class PdfProvider with ChangeNotifier {
  final List<PdfInfo> _pdfList = [
    PdfInfo(path: 'https://firebasestorage.googleapis.com/v0/b/retroflux-cf1ae.appspot.com/o/ch1.pdf?alt=media&token=87ae4400-08fb-42d4-bbe8-803329da6003',favoritePages: [1,3,5]),
    PdfInfo(path: 'https://firebasestorage.googleapis.com/v0/b/retroflux-cf1ae.appspot.com/o/ch1.pdf?alt=media&token=87ae4400-08fb-42d4-bbe8-803329da6003',favoritePages: [1,3,5]),
  ];
  List<PdfInfo> get loadedPdfs{
    return [..._pdfList];
  }
  void addPdfInfo(PdfInfo pdfInfo){
    _pdfList.insert(0, pdfInfo);
    notifyListeners();
  }
}
