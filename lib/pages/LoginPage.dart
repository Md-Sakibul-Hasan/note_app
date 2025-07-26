import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final registerController = Get.find<RegisterController>();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged in successfully')),
        );
      } catch (e) {
        Get.snackbar('Login Failed', e.toString(),
            backgroundColor: Colors.redAccent.withOpacity(0.8),
            colorText: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xFF6D0EB5), Color(0xFF4059F1)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (val) => val!.isEmpty ? "Enter email" : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (val) =>
                          val!.length < 6 ? "Password too short" : null,
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: const Color(0xFF6D0EB5),
                            //   padding: const EdgeInsets.symmetric(vertical: 15),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            // ),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 16,color: Colors.white),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.to(() => SignupPage()),
                          child: const Text(
                            "Don't have an account? Sign up",),
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
}
