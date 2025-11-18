import 'package:dio/dio.dart';
import 'package:shoppify/models/cart_model.dart';


class CartService {
  static Dio dio = Dio();
  static Future<CartModel> getCartById({required int userId}) async {
    try {
      Response response = await dio.get(
        "https://ecommerceflutter2.runasp.net/api/Cart/$userId",
      );
      return CartModel.fromJson(json: response.data);
    } on DioException catch (dioError) {
      throw Exception(dioError.message);
    } catch (otherError) {
      throw Exception(otherError);
    }
  }

  static Future<String> addProductToCart({
    required int productId,
    required int userId,
  }) async {
    try {
      Response response = await dio.post(
        'https://ecommerceflutter2.runasp.net/api/Cart/$userId/add-product',
        data: {"productId": productId},
      );
      return response.data["message"];
    } on DioException catch (dioError) {
      throw Exception(dioError.message);
    } catch (otherError) {
      throw Exception(otherError);
    }
  }

  static Future<String> removeProductFromCart({
    required int productId,
    required int userId,
  }) async {
    try {
      Response response = await dio.delete(
        "https://ecommerceflutter2.runasp.net/api/Cart/$userId/remove-product",
        data: {"productId": productId},
      );
      return response.data["message"];
    } on DioException catch (dioError) {
      throw Exception(dioError.message);
    } catch (otherError) {
      throw Exception(otherError);
    }
  }
}
