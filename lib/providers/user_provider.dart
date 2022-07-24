import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:retroflux/models/user_firestore_info.dart';

class UserProvider with ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<UserFireStoreInfo?> getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        currentUser = user;
        final data = userDoc.data()!;
        return UserFireStoreInfo(
          avatar: data["avatar"],
          email: data["email"],
          location: data["location"],
          major: data["major"],
          name: data["name"],
          other: data["other"],
          category:data["category"]
        );
      }
    }
  }

  User? get getCurrentUser => currentUser;
}
