import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../widgets/sidebar_buttons.dart';

class PdfViewer extends StatefulWidget {
  final String path;
  final List<int> favoritePages;
  final PdfViewerController pdfViewerController;

  const PdfViewer({
    Key? key,
    required this.path,
    required this.favoritePages,
    required this.pdfViewerController,
  }) : super(key: key);

  @override
  State<PdfViewer> createState() => PdfViewerState();

  bool onLike(int page) {
    if (favoritePages.contains(page)) {
      favoritePages.remove(page);
      return false;
    } else {
      favoritePages.add(page);
      return true;
    }
  }
}

class PdfViewerState extends State<PdfViewer> {
  late bool _isFavorite;
  bool _isSpeedMode = true;

  int calculateNextPage(bool isPositiveXDiff) {
    int currPage = widget.pdfViewerController.pageNumber;
    if (!_isSpeedMode) {
      return isPositiveXDiff
          ? max(1, currPage - 1)
          : min(widget.pdfViewerController.pageCount, currPage + 1);
    } else {
      if (isPositiveXDiff) {
        for (var i = currPage - 1; i > 0; i--) {
          if (widget.favoritePages.contains(i)) {
            return i;
          }
        }
        return max(1, currPage - 1);
      } else {
        for (var i = currPage + 1; i <= widget.pdfViewerController.pageCount; i++) {
          if (widget.favoritePages.contains(i)) {
            return i;
          }
        }
        return min(widget.pdfViewerController.pageCount, currPage + 1);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.favoritePages.contains(1);
  }

  @override
  Widget build(BuildContext context) {
    double _downX = 0.0;
    double _upX = 0.0;
    Widget sidebarButtons = SidebarButtons(
        isFavorite: _isFavorite,
        isSpeedMode: _isSpeedMode,
        onAvatar: () {},
        onFavorite: () {
          setState(() {
            _isFavorite = widget.onLike(widget.pdfViewerController.pageNumber);
          });
        },
        onSpeedMode: () {
          setState(() {
            _isSpeedMode = !_isSpeedMode;
          });
        },
        onComment: () {},
        onShare: () {},
        pdfController: widget.pdfViewerController,
    );
    return Stack(children: [
      Listener(
        child: Stack(
          children: [
            Scaffold(
              body: SfPdfViewer.file(
                File(widget.path),
                scrollDirection: PdfScrollDirection.horizontal,
                pageLayoutMode: PdfPageLayoutMode.single,
                controller: widget.pdfViewerController,
              ),
            ),
          ],
        ),
        onPointerDown: (PointerDownEvent event) {
          _downX = event.localPosition.dx;
        },
        onPointerUp: (PointerUpEvent event) {
          _upX = event.localPosition.dx;
          int nextPage = calculateNextPage(_upX > _downX);
          setState(() {
            _isFavorite = widget.favoritePages.contains(nextPage);
          });
          widget.pdfViewerController.jumpToPage(nextPage);
        },
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.bottomRight,
        child: sidebarButtons,
      )
    ]);
  }
}
