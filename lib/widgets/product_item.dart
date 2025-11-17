import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final ProductModel item;
  final int userId;
  const ProductItem({required this.item,required this.userId ,super.key});

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
            builder: (context, value, child) => ElevatedButton(
              onPressed: () {
                if (item.added) {
                  value.removeProductFromCart(userId:userId , productId: item.id);
                } else {
                  value.addProductToCart(userId:userId , productId: item.id);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.added ? Colors.redAccent : Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: Text(item.added ? "Added ✓" : "Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
