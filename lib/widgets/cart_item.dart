import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  CartItemModel item;
  int userId;
  CartItem({required this.item,required this.userId ,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: ListTile(
        leading: Image.network(
          item.image,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.shopping_bag_outlined, color: Colors.teal),
        ),
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Price: \$${item.price}"),

        trailing:  IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            context.read<CartProvider>().removeProductFromCart(userId: userId, productId: item.id);
          },
        ),
      ),
    );
  }
}
