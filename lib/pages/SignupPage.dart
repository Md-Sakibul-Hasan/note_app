import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Handle signup logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created!')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Create an Account", style: TextStyle(fontSize: 24)),
              SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (val) => val!.isEmpty ? "Enter email" : null,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (val) =>
                val!.length < 6 ? "Password too short" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signup, child: Text("Sign up")),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
