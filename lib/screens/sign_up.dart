import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppify/screens/login.dart';

import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 65.0, top: 100),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 47,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              // First Name TextField
              CustomTextField(
                controller: nameController,
                labelText: "Name",
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              // Last Name TextField
              CustomTextField(
                controller: contactController,
                labelText: "phone number",
                icon: Icons.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              // Email TextField
              CustomTextField(
                controller: emailController,
                labelText: "Email",
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              // Password TextField
              CustomTextField(
                controller: passwordController,
                labelText: "Password",
                icon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              // Confirm Password TextField
              const SizedBox(height: 10),
              // Signup button
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),

                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final email = emailController.text.trim();
                      final password = passwordController.text;
                      final contact = contactController.text;
                      final name = nameController.text;

                      final authProvider = context.read<AuthProvider>();
                      final success = await authProvider.register(
                        email: email,
                        password: password,
                        name: name,
                        contact: contact,
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Center(child: Text('Signup Successful')),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Center(child: Text('Invalid email or password')),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Consumer<AuthProvider>(
                    builder: (context, value, child) => value.isLoading
                        ? CircularProgressIndicator()
                        : const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Return to login page
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
