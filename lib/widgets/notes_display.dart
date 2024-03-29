import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/models/pdf_info.dart';
import 'package:retroflux/providers/pdf_provider.dart';
import 'package:retroflux/screens/homepage_screen.dart';
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
  String userUID = FirebaseAuth.instance.currentUser!.uid;
  Future<List<String>> RetriveNotes(String categroy) async {
    List<String> notes = [];
    QuerySnapshot notesSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userUID)
        .collection(widget.category)
        .get();
    for (var element in notesSnapshot.docs) {
      notes.add(element.id);
    }
    return notes;
  }

  Future<String> getNotePath(String noteID) async {
    DocumentSnapshot noteFile = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userUID + "/" + categroy + "/" + noteID)
        .get();
    String notePath = noteFile["file_url"];
    return notePath;
  }

  @override
  Widget build(BuildContext context) {
    final pdfListData = Provider.of<PdfProvider>(context);
    return FutureBuilder(
        future: RetriveNotes(categroy),
        builder: (context, snapshot) {
          List<String> notesList = [];
          if (snapshot.hasData) {
            notesList = snapshot.data as List<String>;
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(categroy),
                backgroundColor: Colors.black87,
              ),
              body: snapshot.hasData
                  ? DecoratedBox(
                      decoration: const BoxDecoration(
                      color: Colors.black
                  ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 1.0),
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,

                                child: GestureDetector(
                                    onTap: () async {
                                      pdfListData.addPdfInfo(PdfInfo(
                                          path: await getNotePath(notesList[index]),
                                          favoritePages: [1]));
                                      Navigator.pushNamed(
                                          context, HomePageScreen.routeName);
                                    },
                                    child: Column(
                                        children:[
                                          Icon(Icons.insert_drive_file,color: Colors.white,size: 70,),
                                          Text(notesList[index],style: TextStyle(color: Colors.white),)
                                      ]
                                    )
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                  : const Center(child: CircularProgressIndicator()));
        });
  }
}
