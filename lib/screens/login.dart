import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppify/screens/home_page.dart';
import 'package:shoppify/screens/sign_up.dart';

import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        //leading: const Icon(Icons.menu,color: Colors.teal,),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 10),
        //     child: Icon(Icons.settings,color: Colors.teal,),
        //   ),
        // ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 93,
              backgroundColor: Colors.teal,
              child: CircleAvatar(
                radius: 90,
                foregroundColor: Colors.teal,
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.teal,
                    size: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Use the CustomTextField widget for email
            CustomTextField(
              controller: emailController,
              labelText: "Email",
              icon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an Email';
                } else if (!value.contains('@gmail.com')) {
                  return 'Email must be a Gmail address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Use the CustomTextField widget for password
            CustomTextField(
              controller: passwordController,
              labelText: "Password",
              icon: Icons.remove_red_eye_rounded,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Password';
                } else if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    final password = passwordController.text;
                    final authProvider = context.read<AuthProvider>();
                    final success = await authProvider.login(
                      email: email,
                      password: password,
                    );

                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Center(
                            child: Text(
                              'Login Successful',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Center(
                            child: Text('Invalid email or password'),
                          ),
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
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: const Text(
                    "Register",
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
    );
  }
}
