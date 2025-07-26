import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/pages/HomePage.dart';

import '../controllers/register_controller.dart';
import 'LoginPage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              log("Auth state changed: ${snapshot.connectionState}, user: ${snapshot.data}");
              User? user = snapshot.data;
              if (user == null) {
                return LoginPage();
              } else {
                return HomePage();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
}
