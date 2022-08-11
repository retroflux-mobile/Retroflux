import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    QuerySnapshot notesSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(widget.category)
        .get();
    for (var element in notesSnapshot.docs) {
      notes.add(element.id);
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RetriveNotes(categroy),
        builder: (context, snapshot) {
          List<String> notesList = [];
          if (snapshot.hasData) {
            notesList = snapshot.data as List<String>;
          }
          return Scaffold(
            appBar:
                AppBar(title: Text(categroy), backgroundColor: Colors.black87),
            body: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
                child: snapshot.hasData
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 1.0),
                        itemCount: notesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: GestureDetector(
                                  onTap: () {}, child: Text(notesList[index])),
                            ),
                          );
                        })
                    : const Center(child: CircularProgressIndicator())),
          );
        });
  }
}
