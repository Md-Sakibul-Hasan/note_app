import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/pages/HomePage.dart';

import '../controllers/register_controller.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final registerController = Get.find<RegisterController>();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  void _signup() async{
    if (_formKey.currentState!.validate()) {
      try{
        registerController.registerUser(name: nameController.text, email: emailController.text, phone: phoneController.text, password: passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
      }catch (e,s) {
        log('register error: $e\n$s');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xFF6D0EB5), Color(0xFF4059F1)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Create Account",
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildTextField("Name", nameController),
                        _buildTextField("Phone", phoneController, keyboardType: TextInputType.phone),
                        _buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress),
                        _buildPasswordField(),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: const Color(0xFF6D0EB5),
                            //   padding: const EdgeInsets.symmetric(vertical: 15),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            // ),
                            onPressed: _signup,
                            child: const Text("Sign Up", style: TextStyle(fontSize: 18,color: Colors.white)),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Already have an account? Login"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (val) => val!.isEmpty ? "Enter $label" : null,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: passwordController,
        obscureText: _obscure,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: IconButton(
            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
        ),
        validator: (val) => val!.length < 6 ? "Password too short" : null,
      ),
    );
  }
}
