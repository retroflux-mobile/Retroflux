import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/chat_message_provider.dart';
import '../models/pdf_info.dart';
import '../providers/pdf_provider.dart';
import '../screens/homepage_screen.dart';

class chatMessageItem extends StatelessWidget {
  const chatMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final pdfListData = Provider.of<PdfProvider>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
      alignment: message.isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: message.isSender ? Colors.grey : Colors.orange,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              message.contentString,
            ),
            message.attachedFilePath == ""
                ? const SizedBox()
                : ElevatedButton.icon(
              onPressed: () async {
                pdfListData.addPdfInfo(PdfInfo(
                    path: message.attachedFilePath, favoritePages: [1]));
                Navigator.pushReplacementNamed(
                    context, HomePageScreen.routeName);
              },
              icon: const Icon(Icons.description),
              label: Text(message.originalFileName),
            )
          ],
        ),
      ),
    );
  }
}
