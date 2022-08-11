import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:retroflux/style_guide.dart';

class AddPageScreen extends StatefulWidget {
  static const String routeName = '/addpage';
  const AddPageScreen({Key? key}) : super(key: key);

  @override
  State<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "If you see this, something is wrong",
        style: testLargeFont,
      ),
    );
  }
}

Future showAddDialog(context) async {
  String currentUID = FirebaseAuth.instance.currentUser!.uid;

  List<dynamic> userCategoriesDynamic = await FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUID)
      .get()
      .then((value) => value["category"]);

  List<String> userCategories = List<String>.from(userCategoriesDynamic);
  return showDialog(
    useSafeArea: false,
    barrierDismissible: true,
    context: context,
    builder: (BuildContext dialogContext) {
      return AddFileDialog(
        userUID: currentUID,
        userCategories: userCategories,
      );
    },
  );
}

class AddFileDialog extends StatefulWidget {
  const AddFileDialog({
    Key? key,
    this.userUID,
    this.userCategories,
  }) : super(key: key);

  final userUID;
  final userCategories;

  @override
  State<AddFileDialog> createState() => _AddFileDialogState();
}

class _AddFileDialogState extends State<AddFileDialog> {
  final fileName = TextEditingController();
  var noteFile;
  String dropdownValue = "Choose category";
  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Choose category"];
    categories += this.widget.userCategories;

    //Todo: implement notifyBackend upon uploading file.

    Future<void> notifyBackend(String fileLink) async {
      var dio = Dio();
      final reference = FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userUID)
          .collection(dropdownValue)
          .doc(fileName.text);

      await reference.set({"file_url": fileLink})
          .then((_){print("Users/${widget.userUID}/$dropdownValue/${fileName.text}");})
          .then((_){
            dio.post('http://10.0.0.229:60117/api/process_pdf',
                data: {"collection_path":"Users/${widget.userUID}/$dropdownValue/${fileName.text}"});
          });

    }

    return Padding(
      padding: const EdgeInsets.only(top: 400.0),
      child: Card(
        margin: EdgeInsets.zero,
        borderOnForeground: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextField(
                maxLength: 12,
                autofocus: true,
                controller: fileName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter File Name Here',
                ),
              ),
            ),
            DropdownButton(
              hint: const Text("Choose Cateory"),
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  print(newValue);
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            OutlinedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  noteFile = File(result.files.single.path!);
                } else {
                  // User canceled the picker
                }
              },
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.upload_rounded,
                        size: 120,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Upload"),
                      )
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if (noteFile == null ||
                          fileName.text == '' ||
                          dropdownValue == "Choose Cateory") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please confirm information")));
                      } else {
                        String filePath = "UserPdf/" +
                            widget.userUID +
                            "/" +
                            dropdownValue +
                            "/" +
                            fileName.text;
                        try {
                          FirebaseStorage.instance
                              .ref()
                              .child(filePath)
                              .putFile(noteFile)
                              .then((_) async {
                            notifyBackend(await FirebaseStorage.instance
                                .ref()
                                .child(filePath).getDownloadURL());
                          }).then((_) => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                      SnackBar(content: Text("Success!"))));
                        } catch (err) {
                          print(err);
                          //Todo: Unhandled EXCEPTION
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Upload failed: " + err.toString())));
                        } finally {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text("Upload"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
