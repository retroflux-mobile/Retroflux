import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/models/pdf_info.dart';
import 'package:retroflux/providers/pdf_provider.dart';
import 'package:retroflux/screens/scroller_screen.dart';

class NotesDisplay extends StatefulWidget {
  static const String routeName = '/notes_display';
  final String category;
  const NotesDisplay({Key? key, required this.category}) : super(key: key);

  @override
  State<NotesDisplay> createState() => _NotesDisplayState();
}

class _NotesDisplayState extends State<NotesDisplay> {
  String get categroy => widget.category;

  Future<List<String>> RetriveNotes(String categroy) async {
    List<String> notes = [];
    QuerySnapshot notesSnapshot = await FirebaseFirestore.instance.collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(widget.category).get();
    for (var element in notesSnapshot.docs) {notes.add(element.id);}
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    final pdfListData = Provider.of<PdfProvider>(context);
    return FutureBuilder(
        future: RetriveNotes(categroy),
        builder: (context,snapshot){
          List<String> notesList = [];
          if(snapshot.hasData){
            notesList = snapshot.data as List<String>;
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(categroy),
              ),
              body: snapshot.hasData
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.0),
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15)),
                            child: GestureDetector(
                                onTap: () {
                                  pdfListData.addPdfInfo(
                                      PdfInfo(
                                        path:'https://firebasestorage.googleapis.com/v0/b/retroflux-cf1ae.appspot.com/o/ch1.pdf?alt=media&token=87ae4400-08fb-42d4-bbe8-803329da6003.pdf',
                                        favoritePages: [1, 4]
                                      )
                                  );
                                  Navigator.pushNamed(context, ScrollerScreen.routeName);
                                },
                                child: Text(notesList[index])),
                          ),
                        );
                      })
            : const Center(child: CircularProgressIndicator()));
        });
  }
}
