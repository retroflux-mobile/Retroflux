import 'dart:io';

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
      child: Text("If you see this, something is wrong",style: testLargeFont,),
    );
  }
}

Future showAddDialog(context){
  User? currentUser = FirebaseAuth.instance.currentUser;
  return showDialog(
    useSafeArea: false,
    barrierDismissible: true,
    context: context,
    builder: (BuildContext dialogContext) {
      return AddFileDialog(userUID: currentUser?.uid,);
    },
  );
}

class AddFileDialog extends StatefulWidget {

  const AddFileDialog({
    Key? key,
    this.userUID,
  }) : super(key: key);

  final userUID;

  @override
  State<AddFileDialog> createState() => _AddFileDialogState();
}

class _AddFileDialogState extends State<AddFileDialog> {
  final fileName = TextEditingController();
  var noteFile;
  String dropdownValue = 'CS';
  List<String> categories = [
    "CS",
    "MATH",
    "PHYSICS"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:400.0),
      child: Card(
        margin: EdgeInsets.zero,
        borderOnForeground: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40,0,40,0),
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
                });
              },
              items: categories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            OutlinedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    noteFile = File(result.files.single.path!);
                  } else {
                    // User canceled the picker
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-120,
                    child: Column(
                      children: const [
                        Icon(Icons.upload_rounded,size: 120,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Upload"),
                        )
                      ],
                    )
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")
                ),
                TextButton(
                    onPressed: (){
                        if(noteFile==null||fileName.text==''){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please confirm information")));
                        }else {
                          try{
                            FirebaseStorage.instance.ref().child("UserPdf").child(
                                widget.userUID).child(dropdownValue).child(fileName.text).putFile(
                                noteFile)
                            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success!"))))
                            ;
                          }catch(err){
                            print(err);
                            //Todo: Unhandled EXCEPTION
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload failed: "+err.toString())));
                          }finally{
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    child: const Text("Upload")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
