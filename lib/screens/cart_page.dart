import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context).user?.customerId;

    if(userId == null){
      return Center(
        child:Text("Must be logged in to view cart"),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Cart",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    final cartList = value.cartModel?.cartItems;

                    if (cartList == null) {
                      value.getCartById(userId: userId);
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        CartItemModel item = cartList[index];
                        return CartItem(item: item);
                      },
                    );
                  }
              ),
            ),

            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.teal),
              child: Center(
                child: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    final total = value.cartModel?.totalPrice;

                    if (total == 0) {
                      return CircularProgressIndicator();
                    }
                    return Text(
                      "Total: \$$total",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );

                  }
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      );
    }
  }
}
