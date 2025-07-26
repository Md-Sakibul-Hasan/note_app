import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        try{
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': name,
            'email': email,
            'phone': phone,
            'profileImage': '',
            'createdAt': Timestamp.now(),
          });
        }catch (e,s) {
          log('Error saving user data: $e\n$s');
          throw Exception('Failed to save user data');
        }
      }
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    String? profileImage,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': name,
          'phone': phone,
          'profileImage': profileImage ?? '',
        });
      } catch (e, s) {
        log('Error updating user profile: $e\n$s');
        throw Exception('Failed to update user profile');
      }
    } else {
      throw Exception('No user is currently logged in');
    }
  }


  Future<void> deleteUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
        await user.delete();
      } catch (e, s) {
        log('Error deleting user: $e\n$s');
        throw Exception('Failed to delete user');
      }
    } else {
      throw Exception('No user is currently logged in');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e, s) {
      log('Error sending password reset email: $e\n$s');
      throw Exception('Failed to send password reset email');
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
           log('user data: ${doc.data()}');
           return doc.data() as Map<String, dynamic>;
        }else{
          return null;
        }
      } catch (e, s) {
        log('Error fetching user data: $e\n$s');
        throw Exception('Failed to fetch user data');
      }
    } else {
      throw Exception('No user is currently logged in');
    }
  }

}