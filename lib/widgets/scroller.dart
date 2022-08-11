import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
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
  late Controller controller;

  @override
  initState() {
    super.initState();
    controller = Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success);
      });
  }

  @override
  Widget build(BuildContext context) {
    return TikTokStyleFullPageScroller(
      contentSize: widget.pdfList.length,
      swipePositionThreshold: 0.05,
      // ^ the fraction of the screen needed to scroll
      swipeVelocityThreshold: 1000,
      // ^ the velocity threshold for smaller scrolls
      controller: controller,
      // ^ registering our own function to listen to page changes
      builder: (BuildContext context, int index) {
        PdfViewerController pdfViewerController = PdfViewerController();
        PdfInfo pi = widget.pdfList[index];
        PdfViewer pv = PdfViewer(
            path: pi.path,
            favoritePages: pi.favoritePages,
            pdfViewerController: pdfViewerController);
        return pv;
      },
    );
  }

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
      {int? currentIndex}) {
    print(
        "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
  }
}
