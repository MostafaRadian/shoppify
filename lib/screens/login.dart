import 'package:flutter/foundation.dart';
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
        title: const Center(
          child: Text("Login", style: TextStyle(fontSize: 24)),
        ),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 95,
              backgroundColor: Colors.black87,
              child: CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvDn1PUP13e4E98krHNV-2WLJRHP4dLenxWIgBizm9pREUSDuR8Z0bIrNbSGAVBQPr4_8&usqp=CAU",
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Use the CustomTextField widget for email
            CustomTextField(
              controller: emailController,
              labelText: "Email",
              icon: Icons.email,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login Successful',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Placeholder()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Consumer<AuthProvider>(
                  builder: (context, value, child) => value.isLoading
                      ? CircularProgressIndicator()
                      : const Text("Login"),
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
                      color: Colors.blue,
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
