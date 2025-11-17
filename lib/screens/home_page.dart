import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shoppify/providers/auth_provider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_item.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthProvider>().user?.customerId;
    if(userId == null){
      return Center(child: Text("Customers must log in first",style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,),),);
    }
      else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shoppify",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Consumer<ProductProvider>(
          builder: (context, value, child) {
            final products = value.model?.products;
            if (products == null) {
              value.getProducts();
              return Center(child: RefreshProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 3,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(item: products[index], userId: userId,);
                  },
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          child: Icon(Icons.shopping_cart, color: Colors.teal),
        ),
      );
    }
  }
}
