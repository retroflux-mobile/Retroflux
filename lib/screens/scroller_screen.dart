import 'package:flutter/material.dart';
import 'package:retroflux/models/pdf_info.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/pdf_provider.dart';

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
    final pdfListData = Provider.of<PdfProvider>(context);
    final pdfList = pdfListData.loadedPdfs;
    return FutureBuilder(
        future: pdfListData.initPDFMessages(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Center(child: Scroller(pdfList: pdfList));
        });
  }
}
