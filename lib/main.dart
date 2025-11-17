import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shoppify/providers/auth_provider.dart';
import 'package:shoppify/providers/cart_provider.dart';
import 'package:shoppify/providers/product_provider.dart';
import 'package:shoppify/screens/home_page.dart';
import 'package:shoppify/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
    );
  }
}
