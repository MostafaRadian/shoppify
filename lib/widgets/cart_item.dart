import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';

class CartItem extends StatelessWidget {
  Product item;
  CartItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: ListTile(
        leading: Icon(item.icon, size: 40, color: Colors.teal),
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Price: \$${item.price}"),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                context.read<ProductProvider>().decreseItems(item);
              },
            ),

            Consumer<ProductProvider>(
              builder: (context, value, child) => Text(
                "${item.quantity}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read<ProductProvider>().increaseItem(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
