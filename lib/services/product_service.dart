import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductsService {
  static Dio dio = Dio();
  static Future<Products> getAllProducts() async {
    try {
      Response response = await dio.get('https://fakestoreapi.com/products');
      return Products.fromJson(json: response.data);
    } on DioException catch (dioError) {
      throw Exception(dioError.message);
    } catch (otherError) {
      throw Exception(otherError);
    }
  }
}
