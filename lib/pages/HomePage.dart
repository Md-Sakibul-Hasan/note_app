import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import 'LoginPage.dart';

class HomePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final resisterController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: resisterController.getUserData(),
      builder: (context, snapshot) {
        final userData = snapshot.data ?? {};

        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard',style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            elevation: 5,
            // flexibleSpace: Container(
            //   decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Colors.deepPurple, Colors.purpleAccent],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //   ),
            // ),
          ),

          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userData['name'] ?? 'No Name', style: const TextStyle( fontSize: 16)),
                  accountEmail: Text(userData['email'] ?? 'No Email',style: const TextStyle( fontSize: 16),),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      (userData['name'] ?? 'U')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [Colors.teal, Colors.indigo],
                    // ),
                    color: Colors.teal,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(userData['phone'] ?? 'No Phone'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Welcome, ${userData['name'] ?? 'Guest'} 👋',
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

}
