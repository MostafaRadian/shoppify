import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  Products? model;

  Future<void> getProducts() async {
    model = await ProductsService.getAllProducts();
    notifyListeners();
  }

}
