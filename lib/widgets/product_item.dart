import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  ProductModel item;
  final int userId;
  ProductItem({required this.item,required this.userId ,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.network(
        item.image,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.shopping_bag_outlined, color: Colors.teal),
      ),
          Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("\$${item.price}"),
          const SizedBox(height: 8),

          Consumer<CartProvider>(
            builder: (context, value, child) {
              final cartList = value.cartModel?.cartItems;
              bool isInCart = cartList?.any((element) => element.id == item.id) ?? false;
             return ElevatedButton(
              onPressed: () {

                if (isInCart) {
                  value.removeProductFromCart(userId:userId , productId: item.id);
                } else {
                  value.addProductToCart(userId:userId , productId: item.id);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isInCart ? Colors.redAccent : Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: Text(isInCart ? "Added ✓" : "Add to Cart"),
            );
            }
          ),
        ],
      ),
    );
  }
}
