import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String path;
  final List<int> favoritesIndices;
  final PdfViewerController pdfViewerController;

  const PdfViewer({
    Key? key,
    required this.path,
    required this.favoritesIndices, 
    required this.pdfViewerController,
  }) : super(key: key);

  @override
  State<PdfViewer> createState() => PdfViewerState();

  void jumpToPrevFavorite(){
    for (var i = pdfViewerController.pageNumber - 1; i > 0; i--) {
      if (favoritesIndices.contains(i)){
        pdfViewerController.jumpToPage(i);
        break;
      }
    }
  }

  void jumpToNextFavorite(){
    for (var i = pdfViewerController.pageNumber + 1; i <= pdfViewerController.pageCount; i++) {
      if (favoritesIndices.contains(i)){
        pdfViewerController.jumpToPage(i);
        break;
      }
    }
  }
}

class PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SfPdfViewer.asset(
            'assets/sample.pdf',
            scrollDirection: PdfScrollDirection.horizontal,
            pageLayoutMode: PdfPageLayoutMode.single,
            controller: widget.pdfViewerController,
        ),
    );
  }
}