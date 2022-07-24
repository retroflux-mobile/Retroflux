import 'package:flutter/material.dart';
import 'package:retroflux/models/pdf_info.dart';

import '../widgets/scroller.dart';

class ScrollerScreen extends StatefulWidget {
  static const String routeName = '/scroller';

  const ScrollerScreen({Key? key}) : super(key: key);

  @override
  State<ScrollerScreen> createState() => _ScrollerScreenState();
}

class _ScrollerScreenState extends State<ScrollerScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scroller(
        pdfList: [
          PdfInfo(path:"assets/sample.pdf", favoritesIndices:[1,3,5]),
          PdfInfo(path:"assets/sample.pdf", favoritesIndices:[2,4]),
        ]
      )
    );
  }
}
