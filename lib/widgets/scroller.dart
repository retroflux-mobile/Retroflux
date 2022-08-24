import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../models/pdf_info.dart';
import '../widgets/pdf_viewer.dart';

class Scroller extends StatefulWidget {
  final List<PdfInfo> pdfList;

  const Scroller({
    Key? key,
    required this.pdfList,
  }) : super(key: key);

  @override
  State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      // ^ the velocity threshold for smaller scrolls
      controller: controller,
      children: widget.pdfList.map((e) {
          PdfViewerController pdfViewerController = PdfViewerController();
          return PdfViewer(path: e.localPath, favoritePages: e.favoritePages, pdfViewerController: pdfViewerController);
        }).toList(),
    );
  }



}
