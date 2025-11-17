import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';

class ProductItem extends StatelessWidget {
  final Product item;
  const ProductItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 70, color: Colors.teal),
          Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("\$${item.price}"),
          const SizedBox(height: 8),

          Consumer<ProductProvider>(
            builder: (context, value, child) => ElevatedButton(
              onPressed: () {
                if (item.added) {
                  value.removeFromCart(item);
                } else {
                  value.addToCart(item);
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
