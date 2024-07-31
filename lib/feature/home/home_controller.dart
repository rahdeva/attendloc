import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<User?> currentUser = Rx<User?>(null);
  User? userData;
  String userName = "";

  @override
  void onInit() async {
    super.onInit();
    currentUser.bindStream(auth.authStateChanges());
    if(currentUser.value == null){
      await signInAnonymously();
    } else {
      debugPrint('User already signed in: ${currentUser.value?.uid}');
      userData = currentUser.value;
      checkUserInFirestore(userData!);
    }
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      User? user = userCredential.user;
      if (user != null) {
        userData = user;
        userName = "Guest";
        debugPrint('Signed in anonymously as user: ${user.uid}');
        checkUserInFirestore(userData!);
      }
    } catch (e) {
      debugPrint('Failed to sign in anonymously: $e');
    }
    update();
  }

  Future<void> checkUserInFirestore(User user) async {
    try{
      final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid).get();
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        userName = data['username'];
        debugPrint('User already exists in Firestore');
      } else {
        userName = "Guest";
        debugPrint('User does not exist in Firestore, creating new user');
      }
    } catch (e) {
      debugPrint('Error checking user in Firestore: $e');
    }
    update();
  }

  void newAccount() async {
    try {
      await auth.signOut();
      userData = null;
      userName = "";
      signInAnonymously();
    } catch (e) {
      debugPrint('Failed to create new account in Firestore: $e');
    }
  }
}
