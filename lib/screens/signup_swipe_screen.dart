import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:retroflux/screens/homepage_screen.dart';
import 'package:retroflux/widgets/StepProgressView.dart';
import 'package:retroflux/widgets/signup_question.dart';

class SignUpSwipeScreen extends StatefulWidget {
  static const String routeName = '/signup_swipe_screen';

  const SignUpSwipeScreen({Key? key}) : super(key: key);

  @override
  State<SignUpSwipeScreen> createState() => _SignUpSwipeScreenState();
}

class _SignUpSwipeScreenState extends State<SignUpSwipeScreen> {

  User? currentUser = FirebaseAuth.instance.currentUser;

  var colors = [Colors.blue, Colors.pink];
  final tags = [
    'Name',
    'Major',
    'Location',
    'Avatar',
    'Email',
    'Other',
    'Submit'
  ];

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  final Color _activeColor = Colors.lightBlue;

  final Color _inactiveColor = Colors.grey;

  final TextStyle _headerStyle =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  final TextStyle _stepStyle =
      const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  int _curPage = 1;

  StepProgressView _getStepProgress() {
    return StepProgressView(
      tags,
      _curPage,
      _stepProgressViewHeight,
      MediaQuery.of(context).size.width,
      _stepCircleRadius,
      _activeColor,
      _inactiveColor,
      _headerStyle,
      _stepStyle,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(
        top: 48.0,
        left: 24.0,
        right: 24.0,
      ),
    );
  }

  Future<bool> _addUserToFirebase() async {
    if (validateAvatarPath() == null &&
        validateName() == null &&
        validateMajor() == null &&
        validateLocation() == null &&
        validateEmail() == null &&
        validateOther() == null) {
      try {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        final avatarUrl = await _addAvatarToCloudStorage();
        await users.doc(currentUser?.uid).set({
          'name': nameField.text,
          'major': majorField.text,
          'location': locationField.text,
          'avatar': avatarUrl,
          'email': emailField.text,
          'other': otherField.text,
        });
        print("User added to Firebase");
        return true;
      } catch (e) {
        rethrow;
      }
    } else {
      const snackBar = SnackBar(
        content: Text('Please ensure all fields are filled out correctly'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Future<String?> _addAvatarToCloudStorage() async {
    Reference? avatarsRef = FirebaseStorage.instance.ref().child('avatars');

    try {
      TaskSnapshot taskSnapshot = await avatarsRef
          .child("${emailField.text}.jpg")
          .putFile(File(avatarPathField.text));

      print(taskSnapshot);
      return taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return null;
  }

  final nameField = TextEditingController();
  final majorField = TextEditingController();
  final locationField = TextEditingController();
  final avatarPathField = TextEditingController();
  final emailField = TextEditingController();
  final otherField = TextEditingController();

  String? validateName() {
    if (nameField.text.isEmpty) {
      return "Please enter ";
    }
    return null;
  }

  String? validateMajor() {
    if (majorField.text.isEmpty) {
      return "Please enter ";
    }
    return null;
  }

  String? validateLocation() {
    if (locationField.text.isEmpty) {
      return "Please enter ";
    }
    return null;
  }

  String? validateAvatarPath() {
    if (avatarPathField.text.isEmpty) {
      return "Please upload an avatar";
    }
    return null;
  }

  String? validateEmail() {
    if (emailField.text.isEmpty) {
      return "Please enter ";
    } else if (!emailField.text.contains('@')) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validateOther() {
    if (otherField.text.isEmpty) {
      return "Please enter your free time";
    } else if (double.parse(otherField.text) < 0) {
      return "Please enter a positive number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(height: 150.0, child: _getStepProgress()),
        Expanded(
          child: PageView(
            onPageChanged: (i) {
              setState(() {
                _curPage = i + 1;
              });
            },
            children: <Widget>[
              SignupQuestion(
                "What's your nickname?",
                "eg. John Doe",
                nameField,
                validateName,
                isAvatar: false,
                isNumber: false,
              ),
              SignupQuestion(
                "What's your major? If you are not a student, please enter NA",
                "eg. Computer Science",
                majorField,
                validateMajor,
                isAvatar: false,
                isNumber: false,
              ),
              SignupQuestion(
                "Where are you from?",
                "eg. New York, NY",
                locationField,
                validateLocation,
                isAvatar: false,
                isNumber: false,
              ),
              SignupQuestion(
                "What's your avatar?",
                "eg. https://example.com/avatar.png",
                avatarPathField,
                validateAvatarPath,
                isAvatar: true,
                isNumber: false,
              ),
              SignupQuestion(
                "What's your email?",
                "eg. example@gmail.com",
                emailField,
                validateEmail,
                isAvatar: false,
                isNumber: false,
              ),
              SignupQuestion(
                "How much free time do you normally have in a day (in hours)?",
                "eg. 2",
                otherField,
                validateOther,
                isAvatar: false,
                isNumber: true,
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Finish Sign Up"),
                  onPressed: () {
                    _addUserToFirebase().then((res) => {
                          if (res)
                            Navigator.of(context)
                                .pushNamed(HomePageScreen.routeName)
                        });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
